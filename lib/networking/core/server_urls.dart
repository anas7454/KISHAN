import 'package:constructo/networking/core/dio_api.dart';

class ServerUrls {
  // --------- 1. TESTING SERVER -----------

  static const String _baseURLServer1 = "https://api-test.carosa.in"; //

  // --------- 2. LIVE  SERVER -----------

  static const String _baseURLServer2 = "https://api.carosa.in"; // live

  // ------------------ get urls --------------------------------------------------

  static String getBaseUrl() {
    switch (DioAPI.currentServer) {
      case EnumCurrentServer.testing:
        return _baseURLServer1;

      case EnumCurrentServer.publish:
        return _baseURLServer2;
    }
  }

  static String getApiBaseUrl() {
    switch (DioAPI.currentServer) {
      case EnumCurrentServer.testing:
        return "$_baseURLServer1/api";

      case EnumCurrentServer.publish:
        return "$_baseURLServer2/api";
    }
  }
}

enum EnumCurrentServer { testing, publish }
