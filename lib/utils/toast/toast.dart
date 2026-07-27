import 'package:constructo_worker/networking/dialogs/error_message_hendling.dart';
import 'package:constructo_worker/utils/toast/custom_tost_for_mobile.dart';
import 'package:flutter/material.dart';

void showToastSuccess(dynamic res, {Color bgColor = Colors.green}) {
  showSnakBarBottomCustomRed(getRespMessageFromApi(res), bgColor: bgColor);
}

void showToastError(dynamic res, {Color bgColor = Colors.red}) {
  showSnakBarBottomCustomRed(getRespMessageFromApi(res), bgColor: bgColor);
}
