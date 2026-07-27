import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:constructo_worker/utils/internet_connectivity_service/connectivity_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

typedef AppConnectivityRetryCallback = Future<void> Function();

class AppConnectivityController extends GetxController
    with WidgetsBindingObserver {
  final RxBool isNoInternet = false.obs;
  final RxBool isRetrying = false.obs;

  final List<_RetryEntry> _retryEntries = [];
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _connectivityDebounceTimer;
  Timer? _resumeCheckTimer;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _listenConnectivity();
  }

  void registerRetryCallback(
    Object owner,
    AppConnectivityRetryCallback callback,
  ) {
    unregisterRetryCallback(owner);
    _retryEntries.add(_RetryEntry(owner: owner, callback: callback));
  }

  void unregisterRetryCallback(Object owner) {
    _retryEntries.removeWhere((entry) => identical(entry.owner, owner));
  }

  Future<bool> isInternetNotConnected() async {
    final bool isNotConnected =
        await ConnectivityService.isInterNetNotConnected();
    _setInternetStatus(isNotConnected, autoRetry: false);
    return isNotConnected;
  }

  Future<void> retry() async {
    if (isRetrying.value) return;

    try {
      isRetrying.value = true;
      final bool isNotConnected = await isInternetNotConnected();
      if (isNotConnected) return;

      if (_retryEntries.isNotEmpty) {
        await _retryEntries.last.callback();
      }
    } finally {
      isRetrying.value = false;
    }
  }

  void _listenConnectivity() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      _updateInternetStatus,
    );

    unawaited(_refreshInternetStatus(autoRetry: false));
  }

  void _updateInternetStatus(List<ConnectivityResult> _) {
    _connectivityDebounceTimer?.cancel();
    _connectivityDebounceTimer = Timer(const Duration(milliseconds: 700), () {
      unawaited(_refreshInternetStatus());
    });
  }

  Future<void> _refreshInternetStatus({bool autoRetry = true}) async {
    final bool isNotConnected =
        await ConnectivityService.isInterNetNotConnected();
    _setInternetStatus(isNotConnected, autoRetry: autoRetry);
  }

  void _setInternetStatus(bool isNotConnected, {required bool autoRetry}) {
    final bool wasNoInternet = isNoInternet.value;

    isNoInternet.value = isNotConnected;

    if (autoRetry && wasNoInternet && !isNotConnected) {
      retry();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;

    _resumeCheckTimer?.cancel();
    _resumeCheckTimer = Timer(const Duration(milliseconds: 500), () {
      unawaited(_refreshInternetStatus());
    });
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivityDebounceTimer?.cancel();
    _resumeCheckTimer?.cancel();
    _connectivitySubscription?.cancel();
    super.onClose();
  }
}

class _RetryEntry {
  final Object owner;
  final AppConnectivityRetryCallback callback;

  const _RetryEntry({required this.owner, required this.callback});
}
