import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:constructo_worker/utils/common/debug_utils.dart';

class ConnectivityService {
  static Future<bool> hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    printDebugCustom("no internet result-->$result");
    return !result.contains(ConnectivityResult.none);
  }

  static Future<bool> checkInternetConnection() async {
    final isOnline = await hasInternet();

    if (!isOnline) {
      printDebugCustom("no internet-->$isOnline");
      // showToastError('No Internet found.');
    }

    return isOnline;
  }

  static Future<bool> isInterNetNotConnected() async {
    return !await hasInternet();
  }
}
