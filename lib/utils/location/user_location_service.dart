import 'package:constructo_worker/networking/user/models/user_location_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserLocationService {
  static final Geocoding _geocoding = Geocoding();

  static Future<String?> permissionError() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return 'Please enable location';
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return 'Please allow location permission from settings';
      }
      if (permission == LocationPermission.denied) {
        return 'Please allow location permission';
      }
      return null;
    } catch (_) {
      return 'Location not available';
    }
  }

  static Future<UserLocationModel> current() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      final List<Placemark> places = await _geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = places.isEmpty ? null : places.first;

      return UserLocationModel.fromMap({
        'address': place?.street,
        'city': place?.locality ?? place?.subAdministrativeArea,
        'state': place?.administrativeArea,
        'pincode': place?.postalCode,
        'latitude': position.latitude,
        'longitude': position.longitude,
      });
    } catch (_) {
      return UserLocationModel()..errorMessage = 'Location not available';
    }
  }
}
