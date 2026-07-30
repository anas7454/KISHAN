import 'dart:async';

import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/auth/onboarding/stepers/step1_onboarding_widget.dart';
import 'package:constructo_worker/screens/auth/onboarding/stepers/step2_onboarding_widget.dart';
import 'package:constructo_worker/screens/auth/onboarding/stepers/step3_onboarding_widget.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/buttons/text_button_custom.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/decorations/border_radius_utils.dart';
import 'package:constructo_worker/utils/theme/decorations/border_utils.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

mixin OnboardingWidgets {
  // footer
  Widget footerWidget() {
    return Container(
      padding: EdgeInsets.only(
        top: 16.rh,
        bottom: bottomstatusBarHeight + 12.rh,
        left: horzontalSpace,
        right: horzontalSpace,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: borderCustomcolorEDEDED(),
        borderRadius: borderRadiusCardOnlyTop(radius: 24.rr),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
                name: "Get Started",
                width: 165.rw,
                fontWeight: FontWeight.w600,
                borderRadiusDouble: 24.rr,
                isSuffix: true,
                imageAsset: CommonIconsUtility.arrowForward,
                onPressed: () {
                  AppRoutes.loginScreen();
                },
              ),
            ],
          ),
          sizedboxHeight(16),
          Text(
            "100% Verified & Trusted Platform",
            textAlign: TextAlign.center,
            style: AppTextStyles.ts14w600colorBlack().copyWith(
              fontSize: 13.rsp,
              fontWeight: FontWeight.w700,
            ),
          ),
          sizedboxHeight(4),
          Text(
            "Your Safety, Identity, & Payments Are Fully Secure With Us.",
            textAlign: TextAlign.center,
            style: AppTextStyles.ts11w400color808080().copyWith(
              fontSize: 11.rsp,
              color: AppColors.color7D7D7D,
            ),
          ),
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
