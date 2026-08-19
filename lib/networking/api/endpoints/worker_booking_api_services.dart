import 'package:constructo_worker/networking/api/app_api_services.dart';

class WorkerBookingApiServices {
  static final Set<String> acceptedBookingIds = <String>{};
  static final Set<String> rejectedBookingIds = <String>{};
  static final List<void Function(String)> _processedListeners =
      <void Function(String)>[];

  static void addProcessedListener(void Function(String) listener) {
    if (!_processedListeners.contains(listener)) {
      _processedListeners.add(listener);
    }
  }

  static void removeProcessedListener(void Function(String) listener) {
    _processedListeners.remove(listener);
  }

  static void _notifyProcessed(String bookingId) {
    for (final listener in List<void Function(String)>.from(
      _processedListeners,
    )) {
      listener(bookingId);
    }
  }

  static Future<Map> getWorkerHistory(String status) {
    return AppApiServices.apiRequest(
      '/api/bookings/worker/history',
      queryParameter: <String, dynamic>{'status': status},
    );
  }

  static Future<Map> getPendingBookings() {
    return AppApiServices.apiRequest(
      '/api/workers/booking/pending',
      queryParameter: <String, dynamic>{
        '_ts': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  static Future<Map> getBookingDetails(String bookingId) {
    return AppApiServices.apiRequest('/api/workers/booking/$bookingId');
  }

  static Future<Map> acceptBooking(String bookingId) {
    return AppApiServices.apiRequest(
      '/api/workers/booking/$bookingId/accept',
      apiType: EnumApiType.put,
    );
  }

  static Future<Map> rejectBooking(String bookingId) {
    return AppApiServices.apiRequest(
      '/api/workers/booking/$bookingId/reject',
      apiType: EnumApiType.put,
    );
  }

  static Future<Map> markArrived(String bookingId) =>
      _updateBookingStatus(bookingId, 'arrived');

  static Future<Map> startInspection(String bookingId) =>
      _updateBookingStatus(bookingId, 'inspection');

  static Future<Map> startWork(String bookingId) =>
      _updateBookingStatus(bookingId, 'start');

  static Future<Map> completeWork(String bookingId, {String? comment}) =>
      _updateBookingStatus(
        bookingId,
        'complete',
        body: comment == null ? null : <String, dynamic>{'comment': comment},
      );

  static Future<Map> addAdditionalSkillServices(
    String bookingId,
    Map<String, dynamic> body,
  ) {
    return AppApiServices.apiRequest(
      '/api/workers/booking/$bookingId/additional-skill-services',
      apiType: EnumApiType.put,
      perms: body,
    );
  }

  static Future<Map> _updateBookingStatus(
    String bookingId,
    String action, {
    Map<String, dynamic>? body,
  }) {
    return AppApiServices.apiRequest(
      '/api/workers/booking/$bookingId/$action',
      apiType: EnumApiType.put,
      perms: body,
    );
  }

  static void markAccepted(String bookingId) {
    rejectedBookingIds.remove(bookingId);
    acceptedBookingIds.add(bookingId);
    _notifyProcessed(bookingId);
  }

  static void markRejected(String bookingId) {
    acceptedBookingIds.remove(bookingId);
    rejectedBookingIds.add(bookingId);
    _notifyProcessed(bookingId);
  }
}
