// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';

void printDebugCustom(dynamic text, {int type = 0}) {
  if (kDebugMode) {
    print('print run vk -->$text');
  }
}

void printDebugCustomRed(dynamic text, {int type = 0}) {
  if (kDebugMode) {
    print('\x1B[31mprint run vk --> $text\x1B[0m');
  }
}

void printJson(dynamic data) {
  if (!kReleaseMode) {
    const encoder = JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(data);
    prettyString.split('\n').forEach(debugPrint);
  }
}
