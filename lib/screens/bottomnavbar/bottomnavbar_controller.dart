import 'package:constructo/screens/bottomnavbar/custom_bottomnavbar/custom_bottomnavbar.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb1_workers/bnb1_workers_screen.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_screen.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_screen.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb4_my_order/bnb4_my_order_screen.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_screen.dart';
import 'package:constructo/utils/images/image_utility/icon_utility.dart';
import 'package:constructo/utils/navigation/double_back_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomnavbarController extends GetxController {
  static const int homeIndex = 2;
  final selectedIndex = homeIndex.obs;
  final DoubleBackToExit _doubleBackToExit = DoubleBackToExit();

  static final List<BottomNavItemData> items = <BottomNavItemData>[
    (
      label: 'Workers',
      icon: IconUtility.bottomNavWorkers,
      selectedIcon: IconUtility.bottomNavWorkersSelected,
      fallback: Icons.business_center_outlined,
      child: Bnb1WorkersScreen(),
    ),
    (
      label: 'Materials',
      icon: IconUtility.bottomNavMaterials,
      selectedIcon: IconUtility.bottomNavMaterialsSelected,
      fallback: Icons.inventory_2_outlined,
      child: Bnb2MaterialScreen(),
    ),
    (
      label: 'Home',
      icon: IconUtility.bottomNavHome,
      selectedIcon: IconUtility.bottomNavHomeSelected,
      fallback: Icons.home_rounded,
      child: Bnb3HomeScreen(),
    ),
    (
      label: 'My Orders',
      icon: IconUtility.bottomNavOrders,
      selectedIcon: IconUtility.bottomNavOrdersSelected,
      fallback: Icons.account_balance_wallet_outlined,
      child: Bnb4MyOrderScreen(),
    ),
    (
      label: 'Profile',
      icon: IconUtility.bottomNavProfile,
      selectedIcon: IconUtility.bottomNavProfileSelected,
      fallback: Icons.person_outline_rounded,
      child: Bnb5MyProfileScreen(),
    ),
  ];

  void selectTab(int index) {
    if (selectedIndex.value == index) return;
    _doubleBackToExit.reset();
    selectedIndex.value = index;
  }

  Future<void> onBackPressed() async {
    if (MediaQuery.viewInsetsOf(Get.context!).bottom > 0) {
      FocusManager.instance.primaryFocus?.unfocus();
      return;
    }
    if (selectedIndex.value != homeIndex) {
      selectedIndex.value = homeIndex;
      return;
    }
    await _doubleBackToExit.handle();
  }
}
