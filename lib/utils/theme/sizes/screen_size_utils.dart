import 'package:flutter/material.dart';
import 'package:get/get.dart';

double heightwithoutAppbar() {
  return MediaQuery.of(Get.context!).size.height -
      AppBar().preferredSize.height -
      MediaQuery.of(Get.context!).padding.top -
      MediaQuery.of(Get.context!).padding.bottom;
}
