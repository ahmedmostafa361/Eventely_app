import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider extends ChangeNotifier {
  LatLng? userLocation;
  LatLng? eventLocation;
  String? eventAddress;
  bool isLoadingLocation = false;

  /// Gets user GPS location
  Future<void> getCurrentLocation() async {
    isLoadingLocation = true;
    notifyListeners();

    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      userLocation = LatLng(position.latitude, position.longitude);
    } else if (permission.isPermanentlyDenied) {
      openAppSettings();
    }

    isLoadingLocation = false;
    notifyListeners();
  }

  Future<void> changeEventLocation(LatLng latLng) async {
    eventLocation = latLng;
    eventAddress = await getLocationDetails();
    notifyListeners();
  }

  /// Call this when opening AddEventScreen fresh (not editing)
  void clearEventLocation() {
    eventLocation = null;
    eventAddress = null;
    notifyListeners();
  }

  Future<String> getLocationDetails() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      eventLocation!.latitude,
      eventLocation!.longitude,
    );
    return "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}";
  }

  /// Google Maps navigation URL — opens real navigation in Google Maps app
  String buildNavigationUrl(double lat, double lng) {
    return 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving';
  }
}
