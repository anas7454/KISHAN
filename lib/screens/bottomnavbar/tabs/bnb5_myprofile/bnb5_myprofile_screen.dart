import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/utils/localization/language_controller.dart';

class Bnb5MyprofileScreen extends StatelessWidget {
  const Bnb5MyprofileScreen({super.key});

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
          'nav_profile'.tr,
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
            // User Header Profile Card
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: const Color(0xFF1E6E38),
                    child: Text('K', style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('किसान रामेश्वर साहू', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2.h),
                        Text('+91 98765 43210', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF5ED),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text('सत्यापित किसान (Verified)', style: TextStyle(fontSize: 10.sp, color: const Color(0xFF1E6E38), fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined, color: Color(0xFF1E6E38)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Settings Menu List
            _buildProfileMenuItem(Icons.language, 'change_language'.tr, () => langController.toggleLanguage()),
            _buildProfileMenuItem(Icons.agriculture, 'मेरी कृषि भूमि एवं विवरण', () {}),
            _buildProfileMenuItem(Icons.history, 'मेरी सेवाएं और इतिहास', () {}),
            _buildProfileMenuItem(Icons.notifications_outlined, 'अधिसूचनाएं (Notifications)', () {}),
            _buildProfileMenuItem(Icons.help_outline, 'सहायता एवं समर्थन (Help)', () {}),
            _buildProfileMenuItem(Icons.privacy_tip_outlined, 'गोपनीयता नीति (Privacy)', () {}),
            SizedBox(height: 12.h),
            _buildProfileMenuItem(Icons.logout, 'लॉग आउट (Logout)', () {}, isDanger: true),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem(IconData icon, String title, VoidCallback onTap, {bool isDanger = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.withOpacity(0.15)),
          ),
          child: Row(
            children: [
              Icon(icon, color: isDanger ? Colors.red : const Color(0xFF1E6E38), size: 22.sp),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDanger ? Colors.red : Colors.black87,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
