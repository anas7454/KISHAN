import 'package:constructo/screens/bottomnavbar/bottomnavbar_controller.dart';
import 'package:constructo/screens/bottomnavbar/custom_bottomnavbar/custom_bottomnavbar.dart';
import 'package:constructo/utils/common/focus_utils.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBarScreen extends StatelessWidget {
  BottomNavBarScreen({super.key});

  final BottomnavbarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool keyboardOpen = mediaQuery.viewInsets.bottom > 0;
    final double bottomNavHeight =
        CustomBottomNav.height.rh - barTop + mediaQuery.padding.bottom;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) await controller.onBackPressed();
      },
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () => removeFocusTwo(),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: keyboardOpen ? 0 : bottomNavHeight,
                    ),
                    child: IndexedStack(
                      index: controller.selectedIndex.value,
                      children: BottomnavbarController.items
                          .map((item) => item.child)
                          .toList(growable: false),
                    ),
                  ),
                ),
                if (!keyboardOpen)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CustomBottomNav(
                      items: BottomnavbarController.items,
                      selectedIndex: controller.selectedIndex.value,
                      onTabChanged: controller.selectTab,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
