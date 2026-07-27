import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void removeFocusTwo({BuildContext? context}) {
  if (Platform.isAndroid) {
    FocusScope.of(context ?? Get.context!).requestFocus(FocusNode());
    FocusScope.of(context ?? Get.context!).requestFocus(FocusNode());
  } else if (Platform.isIOS) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
