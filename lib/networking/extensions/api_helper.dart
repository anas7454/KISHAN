import 'package:flutter/material.dart';

// ------ 1. API SEND VALUE  ----------------------

String? apiSendTextController(TextEditingController textController) {
  try {
    return textController.text.trim().isEmpty
        ? null
        : textController.text.trim();
  } catch (e) {
    return null;
  }
}

// api m formate currency ko shi bheje 20,000 -> 200000
String? apiSendRawPrice(TextEditingController controller) {
  try {
    final text = controller.text.trim();

    if (text.isEmpty) return null;

    return text.replaceAll(',', '');
  } catch (e) {
    return null;
  }
}

num? apiSendNumber(dynamic perm) {
  try {
    return num.tryParse(perm.toString());
  } catch (e) {
    return null;
  }
}

bool? apiSendBool(dynamic perm) {
  try {
    return bool.tryParse(perm.toString());
  } catch (e) {
    return null;
  }
}

String? apiSendString(dynamic value) {
  try {
    if (value == null) return null;
    return value?.isEmpty ? null : value;
  } catch (e) {
    return null;
  }
}

double? apiSendDouble(dynamic perm) {
  if (perm == null) return null;

  final value = perm.toString();
  return double.tryParse(value) ?? int.tryParse(value)?.toDouble();
}

// map send se null , "" , [] ye ht jyenge
Map<String, dynamic> cleanMap(Map<String, dynamic> data) {
  final Map<String, dynamic> cleaned = {};

  data.forEach((key, value) {
    if (value == null) return;

    if (value is String && value.trim().isEmpty) return;

    if (value is List && value.isEmpty) return;

    if (value is Map && value.isEmpty) return;

    cleaned[key] = value;
  });

  return cleaned;
}

String buildQueryString(Map<String, dynamic> params) {
  final List<String> parts = [];

  params.forEach((key, value) {
    if (value == null) return;

    if (value is List) {
      final encoded = value.map((e) => customEncode(e.toString())).join("%2C");
      parts.add("$key=$encoded");
    } else {
      parts.add("$key=${customEncode(value.toString())}");
    }
  });

  return parts.join("&");
}

String customEncode(String value) {
  return value
      .trim()
      .replaceAll(" ", "+") // space → +
      .replaceAll(",", "%2C"); // comma → %2C
}
// -----------------------------

// ------ 2. API GET VALUE PARSE ----------------------

bool apiResponseSuccess(Map response) {
  return apiPeramBool(response['success']) ||
      const [200, 201].contains(apiPeramInt(response['statusCode']));
}

bool apiPeramBool(dynamic perm) {
  return (bool.tryParse(perm.toString()) ?? false);
}

int apiPeramInt(dynamic perm) {
  try {
    return (int.tryParse(perm.toString()) ??
            double.tryParse(perm.toString()) ??
            0)
        .toInt();
  } catch (e) {
    return 0;
  }
}

int? apiPeramIntId(dynamic perm) {
  if (perm == null) return null;
  return int.tryParse(perm.toString());
}

double apiPeramDouble(
  dynamic perm, {
  int? decimal, // kitne decimal chahiye (2, 3, 4...)
}) {
  double value =
      double.tryParse(perm.toString()) ??
      int.tryParse(perm.toString())?.toDouble() ??
      0.0;

  if (decimal != null) {
    return double.parse(value.toStringAsFixed(decimal));
  }

  return value;
}

num apiPeramNumber(dynamic perm) {
  try {
    return (num.tryParse(perm.toString()) ?? 0);
  } catch (e) {
    return 0;
  }
}

String apiPeramString(dynamic perm, {String initialValue = ""}) {
  String myStringValue = (perm ?? '').toString().trim();

  String stringConverted = (myStringValue == 'null'
      ? initialValue
      : myStringValue);
  return stringConverted == "" ? initialValue : stringConverted;
}

String? apiPeramStringId(dynamic perm) {
  if (perm == null) return null;

  String value = perm.toString().trim();

  if (value.isEmpty || value.toLowerCase() == 'null') {
    return null;
  }

  return value;
}

String apiPeramNameString(dynamic perm, {String initialValue = ""}) {
  String myString = apiPeramString(perm);
  if (myString.trim().isEmpty || myString == "null") return initialValue;

  String stringConverted =
      "${myString[0].toUpperCase()}${myString.substring(1)}";
  return stringConverted == "" ? initialValue : stringConverted;
}

Map apiPeramMap(dynamic perm) {
  try {
    return (perm ?? {});
  } catch (e) {
    return {};
  }
}

List apiPeramList(dynamic perm) {
  try {
    return (perm ?? []);
  } catch (e) {
    return [];
  }
}

Map<String, dynamic> apiPeramMapFirstIndexOfList(dynamic perm) {
  try {
    List dataList = apiPeramList(perm);

    if (dataList.isNotEmpty) {
      return dataList.first;
    }
    return <String, dynamic>{};
  } catch (e) {
    return <String, dynamic>{};
  }
}

dynamic apiPermListGetIndex(dynamic list, int index, {var notfoundValue}) {
  try {
    return list[index];
  } catch (e) {
    return notfoundValue ?? "no index $index";
  }
}
