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
