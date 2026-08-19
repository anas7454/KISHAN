import 'package:constructo_worker/networking/api/endpoints/worker_wallet_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  final isLoading = true.obs;
  final isWithdrawing = false.obs;
  final balance = 0.0.obs;
  final totalEarnings = 0.0.obs;
  final totalWithdrawn = 0.0.obs;
  final earnings = <Map<String, dynamic>>[].obs;
  final withdrawals = <Map<String, dynamic>>[].obs;
  final withdrawalAmountController = TextEditingController();

  List<Map<String, dynamic>> get latestTransactions {
    final List<Map<String, dynamic>> combined = <Map<String, dynamic>>[
      ...earnings.map(
        (item) => <String, dynamic>{...item, '_transactionType': 'earning'},
      ),
      ...withdrawals.map(
        (item) => <String, dynamic>{...item, '_transactionType': 'withdrawal'},
      ),
    ];
    combined.sort((a, b) {
      final aDate = DateTime.tryParse(
        (a['createdAt'] ?? a['date'] ?? '').toString(),
      );
      final bDate = DateTime.tryParse(
        (b['createdAt'] ?? b['date'] ?? '').toString(),
      );
      return (bDate ?? DateTime(1970)).compareTo(aDate ?? DateTime(1970));
    });
    return combined;
  }

  @override
  void onInit() {
    super.onInit();
    loadWallet();
  }

  @override
  void onClose() {
    withdrawalAmountController.dispose();
    super.onClose();
  }

  Future<void> loadWallet() async {
    isLoading.value = true;
    final results = await Future.wait<Map>([
      WorkerWalletApiServices.getWallet(),
      WorkerWalletApiServices.getEarnings(),
      WorkerWalletApiServices.getWithdrawals(),
    ]);
    isLoading.value = false;
    final Map walletResponse = results[0];
    if (!apiResponseSuccess(walletResponse)) {
      await showdialogApiError(respMap: walletResponse);
      return;
    }
    final Map wallet = _dataMap(walletResponse);
    balance.value = _number(
      wallet['availableBalance'] ??
          wallet['balance'] ??
          wallet['walletBalance'],
    );
    totalEarnings.value = _number(
      wallet['totalEarnings'] ?? wallet['earnings'] ?? wallet['earnedAmount'],
    );
    totalWithdrawn.value = _number(
      wallet['totalWithdrawn'] ?? wallet['withdrawnAmount'],
    );
    if (apiResponseSuccess(results[1])) {
      earnings.assignAll(
        _dataList(results[1], const ['earnings', 'items', 'transactions']),
      );
    }
    if (apiResponseSuccess(results[2])) {
      withdrawals.assignAll(
        _dataList(results[2], const ['withdrawals', 'items', 'transactions']),
      );
    }
  }

  Future<void> requestWithdrawal() async {
    final double amount =
        double.tryParse(withdrawalAmountController.text.trim()) ?? 0;
    if (amount <= 0 || amount > balance.value) {
      Get.snackbar(
        'Invalid Amount',
        'Enter an amount up to your available balance',
      );
      return;
    }
    isWithdrawing.value = true;
    final Map response = await WorkerWalletApiServices.requestWithdrawal(
      amount,
    );
    isWithdrawing.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    withdrawalAmountController.clear();
    Get.back<void>();
    Get.snackbar('Request Submitted', 'Your withdrawal request was submitted');
    await loadWallet();
  }

  Map _dataMap(Map response) {
    final dynamic raw = response['data'];
    if (raw is Map) {
      final dynamic nested = raw['wallet'] ?? raw['summary'];
      return nested is Map ? nested : raw;
    }
    return <String, dynamic>{};
  }

  List<Map<String, dynamic>> _dataList(Map response, List<String> keys) {
    dynamic raw = response['data'];
    if (raw is Map) {
      for (final key in keys) {
        if (raw[key] is List) {
          raw = raw[key];
          break;
        }
      }
    }
    if (raw is! List) return <Map<String, dynamic>>[];
    return raw
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  double _number(dynamic value) =>
      double.tryParse(value?.toString().replaceAll(',', '') ?? '') ?? 0;
}
