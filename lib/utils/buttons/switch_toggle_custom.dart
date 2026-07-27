import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:flutter/material.dart';

Widget switchToggleBtnCustom(
  bool switchValue, {
  ValueChanged<bool>? onChanged,
  Color? activeColor,
}) {
  return SizedBox(
    width: 28.rw,
    height: 15.rh,
    child: Transform.scale(
      scale: 0.7,
      child: Switch(
        value: switchValue,
        activeTrackColor: activeColor ?? AppColors.primary,
        onChanged: onChanged,
      ),
    ),
  );
}
