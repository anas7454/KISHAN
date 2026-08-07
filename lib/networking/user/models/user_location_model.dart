// ignore_for_file: unnecessary_getters_setters

import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';

class UserLocationModel {
  String _address = "";
  String _city = "";
  String _state = "";
  String _pincode = "";
  double _latitude = 0;
  double _longitude = 0;
  String _errorMessage = "";

  UserLocationModel();

  UserLocationModel.fromMap(Map data) {
    _address = apiPeramString(data['address']);
    _city = apiPeramString(data['city']);
    _state = apiPeramString(data['state']);
    _pincode = apiPeramString(data['pincode']);
    _latitude = apiPeramDouble(data['latitude']);
    _longitude = apiPeramDouble(data['longitude']);
    _errorMessage = apiPeramString(data['errorMessage']);
  }

  String get address => _address;
  String get city => _city;
  String get state => _state;
  String get pincode => _pincode;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get errorMessage => _errorMessage;

  set address(String value) => _address = value;
  set city(String value) => _city = value;
  set state(String value) => _state = value;
  set pincode(String value) => _pincode = value;
  set latitude(double value) => _latitude = value;
  set longitude(double value) => _longitude = value;
  set errorMessage(String value) => _errorMessage = value;

  bool get isValid =>
      latitude != 0 ||
      longitude != 0 ||
      address.isNotEmpty ||
      city.isNotEmpty ||
      state.isNotEmpty;

  String get displayAddress {
    final parts = [
      city,
      state,
      pincode,
    ].map((value) => value.trim()).where((value) => value.isNotEmpty).toList();
    return parts.isEmpty ? 'Location not available' : parts.join(', ');
  }

  Map<String, dynamic> toMap() => {
    'address': address,
    'city': city,
    'state': state,
    'pincode': pincode,
    'latitude': latitude,
    'longitude': longitude,
  };
}
