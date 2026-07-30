import 'package:constructo_worker/screens/bottomnavbar/custom_bottomnavbar/custom_bottomnavbar.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_screen.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_screen.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb4_my_order/bnb4_my_order_screen.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb5_myprofile/bnb5_myprofile_screen.dart';
import 'package:constructo_worker/utils/images/image_utility/icon_utility.dart';
import 'package:constructo_worker/utils/navigation/double_back_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomnavbarController extends GetxController {
  static const int homeIndex = 0;
  final selectedIndex = homeIndex.obs;
  final DoubleBackToExit _doubleBackToExit = DoubleBackToExit();

  static List<BottomNavItemData> get items => <BottomNavItemData>[
    (
      label: 'Home',
      icon: IconUtility.bottomNavHome,
      selectedIcon: IconUtility.bottomNavHomeSelected,
      fallback: Icons.home_rounded,
      child: Bnb3HomeScreen(),
    ),
    (
      label: 'Requests',
      icon: IconUtility.bottomNavMaterials,
      selectedIcon: IconUtility.bottomNavMaterialsSelected,
      fallback: Icons.add_box_outlined,
      child: Bnb2MaterialScreen(mode: RequestsScreenMode.requests),
    ),
    (
      label: 'My Work',
      icon: IconUtility.bottomNavOrders,
      selectedIcon: IconUtility.bottomNavOrdersSelected,
      fallback: Icons.work_history_outlined,
      child: Bnb2MaterialScreen(mode: RequestsScreenMode.myWork),
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
