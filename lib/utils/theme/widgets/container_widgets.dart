import 'package:flutter/material.dart';

Widget containeSqure({required double size, required Widget child}) {
  return SizedBox(width: size, height: size, child: child);
}
