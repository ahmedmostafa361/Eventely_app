import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

// ── INJECTED IMPORTS ────────────────────────────────────────────────────────
import 'package:geocoding/geocoding.dart'; // locationFromAddress()
import 'package:geolocator/geolocator.dart'; // getCurrentPosition()
// ────────────────────────────────────────────────────────────────────────────

import '../providers/location_provider.dart';
import '../utlis/app_colors .dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final MapController _mapController = MapController();

  // ── INJECTED STATE VARIABLES ───────────────────────────────────────────────
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false; // spinner inside search field
  bool _isGpsLoading = false; // spinner inside GPS button
  LatLng? _searchedLocation; // temporary marker for search result
  // ──────────────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    // Location is already fetched in NavBarScreen.initState
    // We just move camera to it after map is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationProvider = Provider.of<LocationProvider>(
        context,
        listen: false,
      );
      if (locationProvider.userLocation != null) {
        _mapController.move(locationProvider.userLocation!, 15);
      }
      if (locationProvider.userLocation == null &&
          !locationProvider.isLoadingLocation) {
        locationProvider.getCurrentLocation().then((_) {
          if (locationProvider.userLocation != null) {
            _mapController.move(locationProvider.userLocation!, 15);
          }
        });
      }
    });
  }

  // ── INJECTED: dispose to avoid memory leaks ────────────────────────────────
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ──────────────────────────────────────────────────────────────────────────

  // ── INJECTED: Search place by name → move map there ───────────────────────
  Future<void> _searchPlace(String query) async {
    if (query.trim().isEmpty) return;

    setState(() => _isSearching = true);

    try {
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        final LatLng result = LatLng(
          locations.first.latitude,
          locations.first.longitude,
        );

        setState(() {
          _searchedLocation = result; // show temporary marker
          _isSearching = false;
        });

        // Move map to the found location so user can confirm by tapping
        _mapController.move(result, 15);
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
            // Float above the bottom hint bar
            margin: EdgeInsets.only(bottom: 70, left: 16, right: 16),
          ),
        );
      }
    }
  }

  // ──────────────────────────────────────────────────────────────────────────

  // ── INJECTED: Go to device GPS location ───────────────────────────────────
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
        desiredAccuracy: LocationAccuracy.high,
      );

      final LatLng myLocation = LatLng(position.latitude, position.longitude);
      setState(() => _isGpsLoading = false);

      // Move map to GPS location — user still needs to tap to confirm
      _mapController.move(myLocation, 16);
    } catch (e) {
      setState(() => _isGpsLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not get your location.'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 70, left: 16, right: 16),
          ),
        );
      }
    }
  }

  // ──────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Map (UNCHANGED) ────────────────────────────────────────────
          Consumer<LocationProvider>(
            builder: (context, locationProvider, child) {
              final center =
                  locationProvider.eventLocation ??
                  locationProvider.userLocation ??
                  LatLng(30.0444, 31.2357);

              return FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: 15,
                  onTap: (tapPosition, latLng) {
                    // Tapping confirms the location and goes back
                    locationProvider.changeEventLocation(latLng);
                    // Clear search marker since user picked manually
                    setState(() => _searchedLocation = null);
                    Future.delayed(Duration(milliseconds: 400), () {
                      Navigator.of(context).pop();
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.evently_app_flutter',
                  ),

                  // User location dot (UNCHANGED)
                  if (locationProvider.userLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: locationProvider.userLocation!,
                          width: 18,
                          height: 18,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                          ),
                        ),
                      ],
                    ),

                  // Previously selected event location marker (UNCHANGED)
                  if (locationProvider.eventLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: locationProvider.eventLocation!,
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),

                  // ── INJECTED: Search result temporary marker ───────────
                  // Orange pin shows where the search result is
                  // User must still TAP to confirm — keeps existing onTap logic
                  if (_searchedLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _searchedLocation!,
                          width: 44,
                          height: 44,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.orange,
                                size: 44,
                              ),
                              // Small pulse indicator so user knows to tap
                              Positioned(
                                top: 4,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  // ────────────────────────────────────────────────────────
                ],
              );
            },
          ),

          // ── INJECTED: Search Bar (top, with GPS button on left) ─────────
          Positioned(
            top: 50,
            left: 60, // leaves room for GPS button
            right: 16,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: _searchPlace,
                decoration: InputDecoration(
                  hintText: 'Search event location...',
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
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          // ──────────────────────────────────────────────────────────────

          // ── INJECTED: GPS Button (top left) ────────────────────────────
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
                    offset: Offset(0, 2),
                  ),
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
                          strokeWidth: 2,
                          color: Colors.blue,
                        ),
                      )
                    : Icon(Icons.my_location, color: Colors.blue, size: 20),
              ),
            ),
          ),
          // ──────────────────────────────────────────────────────────────

          // ── INJECTED: Search result confirmation hint ───────────────────
          // Shows ONLY when a search result is displayed (orange pin)
          // Tells user they need to tap the orange pin to confirm
          if (_searchedLocation != null)
            Positioned(
              bottom: 60,
              left: 16,
              right: 16,
              child: Card(
                color: Colors.orange.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.touch_app, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Tap the orange pin (or anywhere) to confirm this location',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          // ──────────────────────────────────────────────────────────────

          // Bottom hint bar (UNCHANGED)
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.darkBlueColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.touch_app, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Tap on the map to select location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
