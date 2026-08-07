bool apiResponseSuccess(Map response) {
  return apiPeramBool(response['success']) ||
      const [200, 201].contains(apiPeramInt(response['statusCode']));
}

bool apiPeramBool(dynamic perm) => bool.tryParse(perm.toString()) ?? false;

int apiPeramInt(dynamic perm) {
  try {
    return (int.tryParse(perm.toString()) ??
            double.tryParse(perm.toString()) ??
            0)
        .toInt();
  } catch (_) {
    return 0;
  }
}

int? apiPeramIntId(dynamic perm) {
  if (perm == null) return null;
  return int.tryParse(perm.toString());
}

double apiPeramDouble(dynamic perm, {int? decimal}) {
  final double value =
      double.tryParse(perm.toString()) ??
      int.tryParse(perm.toString())?.toDouble() ??
      0.0;
  return decimal == null ? value : double.parse(value.toStringAsFixed(decimal));
}

num apiPeramNumber(dynamic perm) {
  try {
    return num.tryParse(perm.toString()) ?? 0;
  } catch (_) {
    return 0;
  }
}

String apiPeramString(dynamic perm, {String initialValue = ''}) {
  final String value = (perm ?? '').toString().trim();
  return value.isEmpty || value == 'null' ? initialValue : value;
}

String? apiPeramStringId(dynamic perm) {
  if (perm == null) return null;
  final String value = perm.toString().trim();
  return value.isEmpty || value.toLowerCase() == 'null' ? null : value;
}

String apiPeramNameString(dynamic perm, {String initialValue = ''}) {
  final String value = apiPeramString(perm);
  if (value.isEmpty) return initialValue;
  return '${value[0].toUpperCase()}${value.substring(1)}';
}

Map apiPeramMap(dynamic perm) {
  try {
    return perm ?? {};
  } catch (_) {
    return {};
  }
}

List apiPeramList(dynamic perm) {
  try {
    return perm ?? [];
  } catch (_) {
    return [];
  }
}

Map<String, dynamic> apiPeramMapFirstIndexOfList(dynamic perm) {
  try {
    final List list = apiPeramList(perm);
    return list.isEmpty ? <String, dynamic>{} : list.first;
  } catch (_) {
    return <String, dynamic>{};
  }
}

dynamic apiPermListGetIndex(dynamic list, int index, {String? notfoundValue}) {
  try {
    return list[index];
  } catch (_) {
    return notfoundValue ?? 'no index $index';
  }
}
