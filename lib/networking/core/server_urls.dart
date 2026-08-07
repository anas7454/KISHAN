import 'package:constructo_worker/networking/core/dio_api.dart';

class ServerUrls {
  // --------- 1. TESTING SERVER -----------

  static const String _baseURLServer1 =
      "https://constructo.technogigz.co.in"; //

  // --------- 2. LIVE  SERVER -----------

  static const String _baseURLServer2 =
      "https://constructo.technogigz.co.in"; // live

  // ------------------ get urls --------------------------------------------------

  static String getBaseUrl() {
    switch (DioAPI.currentServer) {
      case EnumCurrentServer.testing:
        return _baseURLServer1;

      case EnumCurrentServer.publish:
        return _baseURLServer2;
    }
  }
}

enum EnumCurrentServer { testing, publish }
