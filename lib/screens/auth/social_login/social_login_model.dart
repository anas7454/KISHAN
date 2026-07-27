// ignore_for_file: unnecessary_getters_setters

import 'package:constructo/networking/extensions/api_helper.dart';

class SocialLoginModel {
  String _idToken = "";
  String _error = "";
  EnumSignupBy _signupBy = EnumSignupBy.google;

  SocialLoginModel();

  SocialLoginModel.fromMap(Map data) {
    _idToken = apiPeramString(data['idToken']);
    _error = apiPeramString(data['error']);
    _signupBy = data['signupBy'] == EnumSignupBy.apple.name
        ? EnumSignupBy.apple
        : EnumSignupBy.google;
  }

  String get idToken => _idToken;
  String get error => _error;
  EnumSignupBy get signupBy => _signupBy;

  set idToken(String value) => _idToken = value;
  set error(String value) => _error = value;
  set signupBy(EnumSignupBy value) => _signupBy = value;

  bool get isValid => idToken.isNotEmpty && error.isEmpty;
}

enum EnumSignupBy { google, apple }
