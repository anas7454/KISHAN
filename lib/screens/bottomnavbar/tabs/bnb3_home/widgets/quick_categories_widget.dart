import 'dart:ui';
import 'package:constructo/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

mixin QuickCategoriesWidget {
  static Widget content(List services) {
    return Row(
      spacing: 10.rw,
      children: services.map((item) => card(item.$1, item.$2)).toList(),
    );
  }

  static Widget card(String title, String path) {
    final radius = BorderRadius.circular(13.rr);
    return Expanded(
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 37.38, sigmaY: 37.38),
          child: Container(
            height: 82.rh,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.4471, 1],
                colors: [Color(0xffFBFBFB), Color(0xffFFF1BA)],
              ),
              borderRadius: radius,
              border: Border.all(color: AppColors.colorE8E8E8, width: .88),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                assetImageWidget(path, size: 24.rsp),
                SizedBox(height: 8.rh),
                Text(
                  title,
                  maxLines: 1,
                  style: AppTextStyles.ts10w700colorblack(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
