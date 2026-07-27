// ignore_for_file: empty_catches
import 'package:constructo/networking/core/server_urls.dart';
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

  static String androidPackageId = "com.constructo.app";
  static String iosBundleId = "com.constructo.app";

  // ------------------ SERVER URLS -----------------------

  static String baseURL = ServerUrls.getBaseUrl();
  static String apiBaseURL = ServerUrls.getApiBaseUrl();
  static String imageBaseURL = baseURL;

  // ------------------ CONSTANT URLS --------------------------

  static String dateformate = "yyyy-MM-dd";
  static String testingDealerEmail = kDebugMode ? "user@gmail.com" : "";
}
