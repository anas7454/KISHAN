import 'dart:async';

import 'package:constructo/routes/app_routes.dart';
import 'package:constructo/screens/auth/onboarding/stepers/step1_onboarding_widget.dart';
import 'package:constructo/screens/auth/onboarding/stepers/step2_onboarding_widget.dart';
import 'package:constructo/screens/auth/onboarding/stepers/step3_onboarding_widget.dart';
import 'package:constructo/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo/utils/buttons/text_button_custom.dart';
import 'package:constructo/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/decorations/border_radius_utils.dart';
import 'package:constructo/utils/theme/decorations/border_utils.dart';
import 'package:constructo/utils/theme/sizes/app_sizes.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

mixin OnboardingWidgets {
  // footer
  Widget footerWidget() {
    return Container(
      height: 150.rh,
      padding: EdgeInsets.only(
        bottom: bottomstatusBarHeight,
        left: horzontalSpace,
        right: horzontalSpace,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: borderCustomcolorEDEDED(),
        borderRadius: borderRadiusCardOnlyTop(radius: 20.rr),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          sizedboxHeight(3),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButtonCustom(
                  onPressed: () {
                    AppRoutes.loginScreen();
                  },
                  btnName: "Skip",
                ),

                Button(
                  name: "Next",
                  width: 155.rw,
                  fontWeight: FontWeight.w500,
                  isSuffix: true,
                  imageAsset: CommonIconsUtility.arrowForward,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          //
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Trusted by ",
                  style: AppTextStyles.ts12w500color000000(),
                ),
                TextSpan(
                  text: "10,000+ ",
                  style: AppTextStyles.ts12w500color000000().copyWith(
                    color: AppColors.primary,
                  ),
                ),
                TextSpan(
                  text: "Construction professionals",
                  style: AppTextStyles.ts12w500color000000(),
                ),
              ],
            ),
          ),
          sizedboxHeight(3),
        ],
      ),
    );
  }
}

class PageViewOnboardingWidget extends StatefulWidget {
  const PageViewOnboardingWidget({super.key});

  @override
  State<PageViewOnboardingWidget> createState() =>
      _PageViewOnboardingWidgetState();
}

class _PageViewOnboardingWidgetState extends State<PageViewOnboardingWidget> {
  final List<Widget> _pages = [
    Step1OnboardingWidget.mainContent(),
    Step2OnboardingWidget.mainContent(),
    Step3OnboardingWidget.mainContent(),
  ];

  late final PageController _pageController;
  Timer? _autoPlayTimer;
  late int _currentPage;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = _pages.length * 1000;
    _pageController = PageController(initialPage: _currentPage);

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || !_pageController.hasClients) return;

      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    final int forwardPageOffset =
        (index - _currentIndex + _pages.length) % _pages.length;
    if (forwardPageOffset == 0) return;

    _pageController.animateToPage(
      _currentPage + forwardPageOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
                _currentIndex = page % _pages.length;
              });
            },
            itemBuilder: (context, page) {
              final int index = page % _pages.length;
              return Column(children: [_pages[index]]);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12.rh),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (index) {
              final bool isActive = index == _currentIndex;

              return GestureDetector(
                onTap: () => _goToPage(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: isActive ? 10.rw : 8.rw,
                  height: isActive ? 10.rw : 8.rw,
                  margin: EdgeInsets.symmetric(horizontal: 4.rw),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? AppColors.primary : AppColors.colorC4C4C4,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
