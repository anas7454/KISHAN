import 'package:constructo_worker/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoubleBackToExit {
  final Duration duration;
  final String message;

  DateTime? _lastBackPressAt;

  DoubleBackToExit({
    this.duration = const Duration(seconds: 3),
    this.message = 'Press back again to exit',
  });

  Future<void> handle() async {
    final DateTime now = DateTime.now();
    final DateTime? lastBackPressAt = _lastBackPressAt;

    if (lastBackPressAt != null &&
        now.difference(lastBackPressAt) <= duration) {
      _lastBackPressAt = null;
      await SystemNavigator.pop();
      return;
    }

    _lastBackPressAt = now;
    showToastError({"msg": message}, bgColor: Colors.black87);
  }

  void reset() {
    _lastBackPressAt = null;
  }
}
