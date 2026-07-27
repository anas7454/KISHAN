import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:constructo/utils/common/debug_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// device info
Future<String> deviceNameGet() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    // Android-specific code

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    printDebugCustom('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
    return androidInfo.model;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    printDebugCustom('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
    return iosInfo.utsname.machine;

    // iOS-specific code
  }

  return "";
}

Future<int> deviceVersionAndroid() async {
  // Web par direct 0 return kar do
  if (kIsWeb) {
    return 0;
  }
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    return androidInfo.version.sdkInt; // 33, 34
  } else {
    // IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
    // String version = iosInfo.systemVersion; // 13.1
    return 0;
  }
}

Future<String> deviceIdUniqueGet() async {
  try {
    if (Platform.isAndroid) {
      const AndroidId androidId = AndroidId();
      String? id = await androidId.getId();
      return id ?? ""; // Returns the actual ANDROID_ID 16 digit
    } else if (Platform.isIOS) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? ""; // Unique per vendor
    }
  } catch (e) {
    return "";
  }
  return "";
}

Future<String> getAppVersion() async {
  final packageInfo = await PackageInfo.fromPlatform(); // 1.2.3
  return packageInfo.version;
}

Future<bool> isIpad() async {
  if (Platform.isIOS) {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    printDebugCustom(
      "iosInfo.model.toLowerCase()-->${iosInfo.model.toLowerCase()}",
    );
    return iosInfo.model.toLowerCase().contains("ipad");
  }
  return false;
}

bool isIos() {
  return Platform.isIOS;
  // return kDebugMode ? true : Platform.isIOS;
}
