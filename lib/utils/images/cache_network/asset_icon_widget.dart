import 'package:constructo/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

Widget assetImageWidget(
  String path, {
  IconData? fallback,
  BoxFit? boxfit,
  double? size,
  Color? color,
}) {
  return SizedBox(
    width: size,
    height: size,
    child: Image.asset(
      path,
      width: size,
      height: size,
      fit: boxfit,
      errorBuilder: (_, _, _) => Icon(fallback, size: size, color: color),
    ),
  );
}
