import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/utils/localization/language_controller.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Get.find<LanguageController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: Text(
          'nav_wallet'.tr,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E6E38)),
        ),
        centerTitle: true,
        actions: [
          Obx(() => TextButton.icon(
                onPressed: () => langController.toggleLanguage(),
                icon: Icon(Icons.language, color: const Color(0xFF1E6E38), size: 16.sp),
                label: Text(
                  langController.isHindi.value ? 'English' : 'हिंदी',
                  style: TextStyle(color: const Color(0xFF1E6E38), fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
              )),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            // Wallet Balance Card
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E6E38), Color(0xFF2E8B4A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF1E6E38).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('उपलब्ध वॉलेट बैलेंस', style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('₹ 2,450.00', style: TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.bold)),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('पैसा जोड़ें'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1E6E38),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Recent Transactions List
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'हाल के लेन-देन (Transactions)',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            SizedBox(height: 12.h),

            _buildTransactionTile('रेफरल बोनस (Reward)', '10 May 2024', '+ ₹100.00', Colors.green),
            SizedBox(height: 10.h),
            _buildTransactionTile('ट्रैक्टर बुकिंग भुगतान', '08 May 2024', '- ₹800.00', Colors.red),
            SizedBox(height: 10.h),
            _buildTransactionTile('वॉलेट में पैसे जोड़े गए', '05 May 2024', '+ ₹1,000.00', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile(String title, String date, String amount, Color color) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child: Icon(color == Colors.green ? Icons.arrow_downward : Icons.arrow_upward, color: color, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
                  SizedBox(height: 2.h),
                  Text(date, style: TextStyle(fontSize: 10.sp, color: Colors.grey[600])),
                ],
              ),
            ],
          ),
          Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: color)),
        ],
      ),
    );
  }
}
