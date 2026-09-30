import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/screens/bottomnavbar/bottomnavbar_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_screen.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/all_services/all_services_screen.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb4_my_order/bnb4_my_order_screen.dart';
import 'package:constructo_worker/screens/wallet/wallet_screen.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_screen.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavBarController());

    final List<Widget> pages = [
      const Bnb3HomeScreen(),
      const AllServicesScreen(),
      const Bnb4MyOrderScreen(),
      const WalletScreen(),
      const Bnb5MyprofileScreen(),
    ];

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: pages,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -2)),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: (index) => controller.changeIndex(index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xFF1E6E38),
              unselectedItemColor: Colors.grey[500],
              selectedFontSize: 11.sp,
              unselectedFontSize: 10.sp,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              elevation: 0,
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  activeIcon: const Icon(Icons.home),
                  label: 'nav_home'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.grid_view_outlined),
                  activeIcon: const Icon(Icons.grid_view),
                  label: 'nav_services'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.receipt_long_outlined),
                  activeIcon: const Icon(Icons.receipt_long),
                  label: 'nav_bookings'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  activeIcon: const Icon(Icons.account_balance_wallet),
                  label: 'nav_wallet'.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline),
                  activeIcon: const Icon(Icons.person),
                  label: 'nav_profile'.tr,
                ),
              ],
            ),
          ),
        ));
  }
}
