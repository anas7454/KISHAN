import 'package:get/get.dart';

String? getIdFromRoute({int positionFromEnd = 0}) {
  final uri = Get.rootDelegate.currentConfiguration?.uri;
  if (uri == null) return null;

  final segments = uri.pathSegments;
  if (segments.isEmpty || positionFromEnd >= segments.length) return null;

  return segments[segments.length - 1 - positionFromEnd];
}

String getRouteEndpoint() {
  final uri = Get.rootDelegate.currentConfiguration?.uri;
  if (uri == null) return '';

  final segments = uri.pathSegments;
  if (segments.isEmpty) return '';

  return segments.last.toLowerCase();
}
