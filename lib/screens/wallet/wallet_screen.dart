import 'package:constructo_worker/networking/user/controllers/user_controller.dart';
import 'package:constructo_worker/screens/wallet/wallet_controller.dart';
import 'package:constructo_worker/utils/appbars/appbar_custom.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final WalletController controller = Get.put(WalletController());

  String get workerName {
    if (!Get.isRegistered<UserController>()) return 'Worker';
    final String name = Get.find<UserController>().userData.value.name.trim();
    return name.isEmpty ? 'Worker' : name.split(' ').first;
  }

  String formatMoney(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: amount % 1 == 0 ? 0 : 2,
    );
    return formatter.format(amount);
  }

  String formatTransactionDate(String rawDate) {
    if (rawDate.isEmpty) return '';
    final DateTime? date = DateTime.tryParse(rawDate)?.toLocal();
    if (date == null) return rawDate;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateDay = DateTime(date.year, date.month, date.day);
    final timeStr = DateFormat('HH:mm').format(date);

    if (dateDay == today) {
      return 'Today $timeStr';
    } else if (dateDay == today.subtract(const Duration(days: 1))) {
      return 'Yesterday $timeStr';
    } else {
      return DateFormat('dd MMM, hh:mm a').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      appBar: appBarCustom(title: 'Wallet'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.loadWallet,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.rw, 14.rh, 16.rw, 28.rh),
            children: [
              _balanceCard(),
              sizedboxHeight(22),
              _transactionsHeader(),
              sizedboxHeight(12),
              if (controller.latestTransactions.isEmpty)
                _emptyTransactions()
              else
                ...controller.latestTransactions.map(_transactionTile),
            ],
          ),
        );
      }),
    );
  }

  Widget _balanceCard() {
    return Container(
      padding: EdgeInsets.fromLTRB(18.rw, 18.rh, 18.rw, 14.rh),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18.rr),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello $workerName,',
                      style: TextStyle(
                        fontSize: 15.rsp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.black,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      'Your available balance',
                      style: TextStyle(
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withValues(alpha: .7),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                formatMoney(controller.balance.value),
                style: TextStyle(
                  fontSize: 25.rsp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          sizedboxHeight(18),
          Row(
            children: [
              Expanded(
                child: _walletAction(
                  icon: Icons.swap_horiz_rounded,
                  label: 'withdrawal',
                  onTap: controller.balance.value > 0 ? _showWithdrawal : null,
                ),
              ),
              Container(
                width: 1,
                height: 38.rh,
                color: AppColors.black.withValues(alpha: .15),
              ),
              Expanded(
                child: _walletAction(
                  icon: Icons.history_rounded,
                  label: 'History',
                  onTap: _showWithdrawalHistory,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _walletAction({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.rr),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.rh),
        child: Column(
          children: [
            Icon(icon, size: 25.rsp, color: AppColors.black),
            sizedboxHeight(4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.rsp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _transactionsHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Latest Transactions',
            style: TextStyle(
              fontSize: 15.rsp,
              fontWeight: FontWeight.w800,
              color: AppColors.black,
            ),
          ),
        ),
        InkWell(
          onTap: _showWithdrawalHistory,
          child: Text(
            'View all',
            style: TextStyle(
              fontSize: 12.rsp,
              fontWeight: FontWeight.w500,
              color: AppColors.color7D7D7D,
            ),
          ),
        ),
      ],
    );
  }

  Widget _transactionTile(Map<String, dynamic> item) {
    final bool isEarning = item['_transactionType'] == 'earning';
    final double amount = double.tryParse(
          (item['amount'] ?? item['netAmount'] ?? item['earning'] ?? 0).toString(),
        ) ??
        0;
    final String reference = (item['bookingNumber'] ??
            item['referenceId'] ??
            item['transactionId'] ??
            item['title'] ??
            (isEarning ? 'Booking Earning' : 'Withdrawal'))
        .toString();
    final String rawDate = (item['createdAt'] ?? item['date'] ?? '').toString();
    final String dateText = formatTransactionDate(rawDate);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.rh),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffEEEEEE), width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.rw,
            height: 40.rw,
            decoration: BoxDecoration(
              color: isEarning ? const Color(0xffE4F5F8) : const Color(0xff1877F2),
              borderRadius: BorderRadius.circular(10.rr),
            ),
            child: Icon(
              isEarning ? Icons.arrow_upward_rounded : Icons.swap_horiz_rounded,
              size: 20.rsp,
              color: isEarning ? const Color(0xff14B8A6) : Colors.white,
            ),
          ),
          sizedboxWidth(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reference,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.rsp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.black,
                  ),
                ),
                sizedboxHeight(2),
                Text(
                  dateText,
                  style: TextStyle(
                    fontSize: 10.rsp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color7D7D7D,
                  ),
                ),
              ],
            ),
          ),
          sizedboxWidth(8),
          Text(
            '${isEarning ? '+' : '-'}${formatMoney(amount)}',
            style: TextStyle(
              fontSize: 12.rsp,
              fontWeight: FontWeight.w800,
              color: isEarning ? const Color(0xff16A34A) : const Color(0xffE02E32),
            ),
          ),
          sizedboxWidth(6),
          Icon(
            Icons.chevron_right_rounded,
            size: 17.rsp,
            color: AppColors.color7D7D7D,
          ),
        ],
      ),
    );
  }

  Widget _emptyTransactions() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.rh),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48.rsp,
            color: AppColors.color7D7D7D,
          ),
          sizedboxHeight(8),
          Text(
            'No transactions found',
            style: AppTextStyles.ts12w500color808080(),
          ),
        ],
      ),
    );
  }

  void _showWithdrawal() {
    Get.bottomSheet<void>(
      Obx(
        () => Container(
          padding: EdgeInsets.fromLTRB(
            20.rw,
            20.rh,
            20.rw,
            MediaQuery.viewInsetsOf(Get.context!).bottom + 20.rh,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22.rr)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Request Withdrawal',
                style: AppTextStyles.ts18w700color000000(),
              ),
              sizedboxHeight(5),
              Text(
                'Available: ${formatMoney(controller.balance.value)}',
                style: AppTextStyles.ts12w500color808080(),
              ),
              sizedboxHeight(14),
              TextField(
                controller: controller.withdrawalAmountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  prefixText: '₹ ',
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              sizedboxHeight(14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isWithdrawing.value
                      ? null
                      : controller.requestWithdrawal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    foregroundColor: AppColors.white,
                  ),
                  child: controller.isWithdrawing.value
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Submit Request'),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showWithdrawalHistory() {
    Get.bottomSheet<void>(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * .7),
        padding: EdgeInsets.fromLTRB(18.rw, 18.rh, 18.rw, 24.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.rr)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Withdrawal History',
                    style: AppTextStyles.ts18w700color000000(),
                  ),
                ),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            if (controller.withdrawals.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.rh),
                child: const Center(child: Text('No withdrawals found')),
              )
            else
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: controller.withdrawals
                      .map(
                        (item) => _transactionTile(<String, dynamic>{
                          ...item,
                          '_transactionType': 'withdrawal',
                        }),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
