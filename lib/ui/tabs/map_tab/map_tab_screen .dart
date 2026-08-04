import 'dart:convert';
import 'package:evently_app_flutter/ui/tabs/map_tab/widget/event_list_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http; // for OSRM routing API

import '../../../providers/location_provider.dart';
import '../../../providers/event_list_provider.dart';
import '../../../model/event.dart';

class MapTabScreen extends StatefulWidget {
  const MapTabScreen({super.key});

  @override
  State<MapTabScreen> createState() => _MapTabScreenState();
}

class _MapTabScreenState extends State<MapTabScreen> {
  final MapController _mapController = MapController();
  int selectedEventIndex = -1;

  // Search state
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _isGpsLoading = false;
  LatLng? _searchedLocation;

  // ── Route state ────────────────────────────────────────────────────────────
  List<LatLng> _routePoints = []; // decoded polyline points from OSRM
  String? _travelTime; // e.g. "12 min"
  String? _travelDistance; // e.g. "3.4 km"
  bool _isLoadingRoute = false; // spinner while fetching route
  // ──────────────────────────────────────────────────────────────────────────

  void updateCamera(LatLng target, {double zoom = 15}) {
    _mapController.move(target, zoom);
  }

  // ── Route: fetch from OSRM (free, no API key needed) ──────────────────────
  // OSRM is the Open Source Routing Machine — same engine behind many map apps
  // Endpoint: router.project-osrm.org/route/v1/driving/lng,lat;lng,lat
  Future<void> _fetchRoute(LatLng from, LatLng to) async {
    setState(() {
      _isLoadingRoute = true;
      _routePoints = [];
      _travelTime = null;
      _travelDistance = null;
    });

    try {
      // OSRM uses longitude FIRST, then latitude (opposite of LatLng)
      final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/'
            '${from.longitude},${from.latitude};'
            '${to.longitude},${to.latitude}'
            '?overview=full&geometries=geojson',
      );

      final response = await http.get(url).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final route = data['routes'][0];

        // ── Decode route geometry (GeoJSON coordinates array) ─────────
        // Each coordinate is [longitude, latitude] in GeoJSON format
        final coords = route['geometry']['coordinates'] as List;
        final List<LatLng> points = coords
            .map((c) => LatLng(c[1].toDouble(), c[0].toDouble()))
            .toList();

        // ── Parse duration and distance ───────────────────────────────
        final double durationSeconds = route['duration'].toDouble();
        final double distanceMeters = route['distance'].toDouble();

        final int minutes = (durationSeconds / 60).round();
        final double km = distanceMeters / 1000;

        setState(() {
          _routePoints = points;
          _travelTime = minutes < 60
              ? '$minutes min'
              : '${(minutes / 60).floor()}h ${minutes % 60}min';
          _travelDistance = '${km.toStringAsFixed(1)} km';
          _isLoadingRoute = false;
        });

        // Fit map to show the full route between user and event
        _fitRouteBounds(from, to);
      } else {
        _clearRoute();
      }
    } catch (e) {
      _clearRoute();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not load route. Check your connection.'),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .size
                  .height * 0.28,
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    }
  }

  // Fit camera to show both user location and event on screen
  void _fitRouteBounds(LatLng from, LatLng to) {
    final bounds = LatLngBounds.fromPoints([from, to]);
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: EdgeInsets.only(
          top: 120, // below search bar
          bottom: 220, // above event cards
          left: 40,
          right: 40,
        ),
      ),
    );
  }

  void _clearRoute() {
    setState(() {
      _routePoints = [];
      _travelTime = null;
      _travelDistance = null;
      _isLoadingRoute = false;
    });
  }

  // ──────────────────────────────────────────────────────────────────────────

  // Search place by name
  Future<void> _searchPlace(String query) async {
    if (query
        .trim()
        .isEmpty) return;
    setState(() => _isSearching = true);
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final LatLng result =
        LatLng(locations.first.latitude, locations.first.longitude);
        setState(() {
          _searchedLocation = result;
          _isSearching = false;
        });
        updateCamera(result, zoom: 15);
        FocusScope.of(context).unfocus();
      }
    } catch (e) {
      setState(() => _isSearching = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Place not found. Try a more specific name.'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .size
                  .height * 0.28,
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    }
  }

  // Go to GPS location
  Future<void> _goToMyLocation() async {
    setState(() => _isGpsLoading = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        setState(() => _isGpsLoading = false);
        return;
      }
      if (permission == LocationPermission.denied) {
        setState(() => _isGpsLoading = false);
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final LatLng myLocation =
      LatLng(position.latitude, position.longitude);
      setState(() => _isGpsLoading = false);
      updateCamera(myLocation, zoom: 16);
    } catch (e) {
      setState(() => _isGpsLoading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;
    var locationProvider = Provider.of<LocationProvider>(context);
    var eventProvider = Provider.of<EventListProvider>(context);
    final locatedEvents = eventProvider.eventsWithLocation;

    final initialCenter = locationProvider.userLocation
        ?? (locatedEvents.isNotEmpty
            ? LatLng(locatedEvents[0].lat!, locatedEvents[0].long!)
            : LatLng(30.0444, 31.2357));

    // Circle markers — selected = blue, others = dark
    List<CircleMarker> circles = List.generate(locatedEvents.length, (i) {
      final isSelected = i == selectedEventIndex;
      return CircleMarker(
        point: LatLng(locatedEvents[i].lat!, locatedEvents[i].long!),
        radius: 18,
        color: isSelected
            ? Colors.blue.withValues(alpha: 0.6)
            : Colors.black.withValues(alpha: 0.45),
        borderColor: isSelected ? Colors.blue : Colors.black54,
        borderStrokeWidth: 3,
      );
    });

    return Stack(
      children: [
        // ── Map ──────────────────────────────────────────────────────────
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: initialCenter,
            initialZoom: 14,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.evently_app_flutter',
            ),

            // ── Route polyline layer ──────────────────────────────────
            // Drawn UNDER circles so markers appear on top of the line
            if (_routePoints.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    color: Colors.blue,
                    strokeWidth: 5.0,
                    // Dashed pattern makes it look like Google Maps route
                    pattern: StrokePattern.dashed(segments: [12, 6]),
                  ),
                ],
              ),
            // ────────────────────────────────────────────────────────

            CircleLayer(circles: circles),

            // Tappable transparent markers on top of each circle
            // CircleMarker has no onTap — invisible markers catch the taps
            MarkerLayer(
              markers: List.generate(locatedEvents.length, (i) {
                final event = locatedEvents[i];
                return Marker(
                  point: LatLng(event.lat!, event.long!),
                  width: 44,
                  height: 44,
                  child: GestureDetector(
                    onTap: () {
                      // Exact same logic as tapping the event card
                      setState(() => selectedEventIndex = i);
                      updateCamera(LatLng(event.lat!, event.long!), zoom: 16);
                      if (locationProvider.userLocation != null) {
                        _fetchRoute(
                          locationProvider.userLocation!,
                          LatLng(event.lat!, event.long!),
                        );
                      } else {
                        locationProvider.getCurrentLocation().then((_) {
                          if (locationProvider.userLocation != null) {
                            _fetchRoute(
                              locationProvider.userLocation!,
                              LatLng(event.lat!, event.long!),
                            );
                          }
                        });
                      }
                    },
                    child: Container(color: Colors.transparent),
                  ),
                );
              }),
            ),

            // User location blue dot
            if (locationProvider.userLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: locationProvider.userLocation!,
                    width: 20,
                    height: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.4),
                            blurRadius: 8,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            // Search result marker
            if (_searchedLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _searchedLocation!,
                    width: 40,
                    height: 40,
                    child: Icon(Icons.location_pin,
                        color: Colors.red, size: 40),
                  ),
                ],
              ),
          ],
        ),

        // ── Search Bar ───────────────────────────────────────────────────
        Positioned(
          top: 50,
          left: 60,
          right: 16,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28)),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: _searchPlace,
              decoration: InputDecoration(
                hintText: 'Search location...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: _isSearching
                    ? Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                    : _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchedLocation = null);
                  },
                )
                    : null,
                border: InputBorder.none,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),

        // ── GPS Button ───────────────────────────────────────────────────
        Positioned(
          top: 50,
          left: 16,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2))
              ],
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: _isGpsLoading ? null : _goToMyLocation,
              icon: _isGpsLoading
                  ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.blue),
              )
                  : Icon(Icons.my_location, color: Colors.blue, size: 20),
            ),
          ),
        ),

        // ── Travel time banner ───────────────────────────────────────────
        // Shows ONLY when a route is loaded — floats above the event cards
        if (_travelTime != null)
          Positioned(
            bottom: screenSize.height * 0.22 + 12,
            left: 16,
            right: 16,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              color: Colors.white,
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    // Blue route icon
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.directions_car,
                          color: Colors.white, size: 18),
                    ),
                    SizedBox(width: 12),

                    // Time + distance
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _travelTime!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        if (_travelDistance != null)
                          Text(
                            _travelDistance!,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                      ],
                    ),
                    Spacer(),

                    // Clear route button
                    IconButton(
                      onPressed: _clearRoute,
                      icon: Icon(Icons.close, color: Colors.grey),
                      tooltip: 'Clear route',
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Route loading spinner — shows while fetching from OSRM
        if (_isLoadingRoute)
          Positioned(
            bottom: screenSize.height * 0.22 + 12,
            left: 16,
            right: 16,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 12),
                    Text('Calculating route...',
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ),

        // ── Horizontal Event Cards ────────────────────────────────────────
        if (locatedEvents.isNotEmpty)
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              // height = card (0.17) + top/bottom padding
              height: screenSize.height * 0.21,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: locatedEvents.length,
                itemBuilder: (context, index) {
                  final isSelected = index == selectedEventIndex;
                  final event = locatedEvents[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedEventIndex = index);
                      updateCamera(
                          LatLng(event.lat!, event.long!), zoom: 16);

                      // ── Fetch route when user taps a card ─────────────
                      // Only fetch if we know the user's current location
                      if (locationProvider.userLocation != null) {
                        _fetchRoute(
                          locationProvider.userLocation!,
                          LatLng(event.lat!, event.long!),
                        );
                      } else {
                        // No location yet — try to get it first
                        locationProvider.getCurrentLocation().then((_) {
                          if (locationProvider.userLocation != null) {
                            _fetchRoute(
                              locationProvider.userLocation!,
                              LatLng(event.lat!, event.long!),
                            );
                          }
                        });
                      }
                      // ────────────────────────────────────────────────
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? Colors.blue.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      // Pass travelTime to card — only show on selected card
                      child: MapEventItem(
                        eventModel: event,
                        travelTime: isSelected ? _travelTime : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}