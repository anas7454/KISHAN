// ignore_for_file: empty_catches
import 'package:constructo_worker/networking/core/server_urls.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';

class DioAPI {
  // -------------------------------------------------------------------

  static EnumCurrentServer currentServer =
      // //
      // kDebugMode
      // ?
      // EnumCurrentServer.testing
      // :
      //   //
      EnumCurrentServer.publish; // publish

  // static const bool isTestAds = kDebugMode ? true : false;
  static const bool isTestAds = false;

  static String androidPackageId = "com.constructo.worker";
  static String iosBundleId = "com.constructo.worker";

  // ------------------ SERVER URLS -----------------------

  static String baseURL = ServerUrls.getBaseUrl();
  static String imageBaseURL = baseURL;

  static const String supportEmail = 'support@Fleetgo';

  static const String supportPhone = '+918770330046';

  // ------------------ CONSTANT URLS --------------------------

  static String dateformate = "yyyy-MM-dd";
}
