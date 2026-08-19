import 'package:constructo_worker/networking/api/app_api_services.dart';
import 'package:flutter/foundation.dart';

class WorkerWalletApiServices {
  static Future<Map> getWallet() {
    _printApi('GET', '/api/workers/wallet');
    return AppApiServices.apiRequest('/api/workers/wallet');
  }

  static Future<Map> getEarnings() {
    _printApi('GET', '/api/workers/earnings');
    return AppApiServices.apiRequest('/api/workers/earnings');
  }

  static Future<Map> getWithdrawals() {
    _printApi('GET', '/api/workers/wallet/withdrawals');
    return AppApiServices.apiRequest('/api/workers/wallet/withdrawals');
  }

  static Future<Map> requestWithdrawal(num amount) {
    _printApi(
      'POST',
      '/api/workers/wallet/withdrawals',
      body: <String, dynamic>{'amount': amount},
    );
    return AppApiServices.apiRequest(
      '/api/workers/wallet/withdrawals',
      apiType: EnumApiType.post,
      perms: <String, dynamic>{'amount': amount},
    );
  }

  static void _printApi(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
  }) {
    debugPrint(
      '[WALLET_API] $method ${AppApiServices.apiBaseURL}$endpoint'
      '${body == null ? '' : ' | body: $body'}',
    );
  }
}
