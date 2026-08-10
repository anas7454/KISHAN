import 'package:constructo_worker/networking/api/app_api_services.dart';

class WorkerBookingApiServices {
  static Future<Map> getWorkerHistory(String status) {
    return AppApiServices.apiRequest(
      '/api/bookings/worker/history',
      queryParameter: <String, dynamic>{'status': status},
    );
  }

  static Future<Map> getPendingBookings() {
    return AppApiServices.apiRequest('/api/workers/booking/pending');
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
}
