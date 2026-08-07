import 'package:flutter/material.dart';

String? apiSendTextController(TextEditingController textController) {
  try {
    return textController.text.trim().isEmpty
        ? null
        : textController.text.trim();
  } catch (_) {
    return null;
  }
}

String? apiSendRawPrice(TextEditingController controller) {
  try {
    final String text = controller.text.trim();
    return text.isEmpty ? null : text.replaceAll(',', '');
  } catch (_) {
    return null;
  }
}

num? apiSendNumber(dynamic perm) => num.tryParse(perm.toString());

bool? apiSendBool(dynamic perm) => bool.tryParse(perm.toString());

String? apiSendString(dynamic value) {
  if (value == null) return null;
  try {
    return value.isEmpty ? null : value;
  } catch (_) {
    return null;
  }
}

double? apiSendDouble(dynamic perm) {
  if (perm == null) return null;
  final String value = perm.toString();
  return double.tryParse(value) ?? int.tryParse(value)?.toDouble();
}

dynamic cleanMap(dynamic data) {
  if (data == null || data is! Map<String, dynamic>) return data;
  final Map<String, dynamic> cleaned = {};
  data.forEach((key, value) {
    if (value == null ||
        value is String && value.trim().isEmpty ||
        value is List && value.isEmpty ||
        value is Map && value.isEmpty) {
      return;
    }
    cleaned[key] = value;
  });
  return cleaned;
}

String buildQueryString(Map<String, dynamic> params) {
  final List<String> parts = [];
  params.forEach((key, value) {
    if (value == null) return;
    if (value is List) {
      final String encoded = value.map((e) => customEncode('$e')).join('%2C');
      parts.add('$key=$encoded');
    } else {
      parts.add('$key=${customEncode('$value')}');
    }
  });
  return parts.join('&');
}

String customEncode(String value) =>
    value.trim().replaceAll(' ', '+').replaceAll(',', '%2C');
