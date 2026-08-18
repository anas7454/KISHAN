import 'dart:async';

import 'package:constructo_worker/networking/api/endpoints/worker_booking_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/widgets/request_card_widget.dart';
import 'package:constructo_worker/screens/request_details/request_details_model.dart';
import 'package:get/get.dart';

enum RequestFilterTab { all, newReq, pending, accepted, rejected }

class RequestItemModel {
  final String bookingId;
  final String title;
  final String requestId;
  final String date;
  final String? startDate;
  final String amount;
  final String address;
  final WorkerRequestStatus status;

  RequestItemModel({
    this.bookingId = '',
    required this.title,
    required this.requestId,
    required this.date,
    this.startDate,
    required this.amount,
    required this.address,
    required this.status,
  });
}

class Bnb2MaterialController extends GetxController {
  Bnb2MaterialController({this.isMyWork = false});

  final bool isMyWork;
  final GlobalController globalController = Get.find();
  final Rx<RequestFilterTab> selectedFilter = RequestFilterTab.all.obs;
  final RxBool isHistoryLoading = false.obs;
  final RxBool isRequestsLoading = false.obs;
  int _historyRequest = 0;
  Timer? _requestsPollingTimer;
  bool _isPendingRequestInFlight = false;

  final RxList<RequestItemModel> allRequests = <RequestItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    WorkerBookingApiServices.addProcessedListener(removePendingBooking);
    if (isMyWork) {
      selectedFilter.value = RequestFilterTab.accepted;
      getWorkerHistory(RequestFilterTab.accepted);
    } else {
      selectedFilter.value = RequestFilterTab.newReq;
      getPendingRequests();
      _startRequestsPolling();
    }
  }

  void _startRequestsPolling() {
    _requestsPollingTimer?.cancel();
    _requestsPollingTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      getPendingRequests(showError: false, showLoading: false);
    });
  }

  @override
  void onReady() {
    super.onReady();
    if (!isMyWork) {
      _startRequestsPolling();
      getPendingRequests(showError: false, showLoading: false);
    }
  }

  @override
  void onClose() {
    WorkerBookingApiServices.removeProcessedListener(removePendingBooking);
    _requestsPollingTimer?.cancel();
    super.onClose();
  }

  List<RequestItemModel> get filteredRequests {
    switch (selectedFilter.value) {
      case RequestFilterTab.all:
        return allRequests;
      case RequestFilterTab.newReq:
        return allRequests
            .where((r) => r.status == WorkerRequestStatus.newRequest)
            .toList();
      case RequestFilterTab.pending:
        return allRequests
            .where((r) => r.status == WorkerRequestStatus.newRequest)
            .toList();
      case RequestFilterTab.accepted:
        return allRequests
            .where((r) => r.status == WorkerRequestStatus.accepted)
            .toList();
      case RequestFilterTab.rejected:
        return allRequests
            .where((r) => r.status == WorkerRequestStatus.rejected)
            .toList();
    }
  }

  void changeFilter(RequestFilterTab filter) {
    if (selectedFilter.value == filter) return;
    selectedFilter.value = filter;
    if (isMyWork) getWorkerHistory(filter);
  }

  /// Reloads only the data shown by this tab. The screen and selected tab stay
  /// mounted while [RefreshIndicator] displays its pull-to-refresh progress.
  Future<void> refreshData() async {
    await globalController.fetchUserLocation(refresh: true);
    if (isMyWork) {
      await getWorkerHistory(selectedFilter.value);
    } else {
      await getPendingRequests();
    }
  }

  Future<void> getPendingRequests({
    bool showError = true,
    bool showLoading = true,
  }) async {
    if (_isPendingRequestInFlight) return;
    _isPendingRequestInFlight = true;
    if (showLoading) isRequestsLoading.value = true;
    final Map response = await WorkerBookingApiServices.getPendingBookings();
    _isPendingRequestInFlight = false;
    if (showLoading) isRequestsLoading.value = false;
    if (!apiResponseSuccess(response)) {
      if (showError) await showdialogApiError(respMap: response);
      return;
    }

    final dynamic responseData = response['data'];
    final List bookings = responseData is List
        ? responseData
        : apiPeramList(
            responseData is Map
                ? responseData['bookings'] ??
                      responseData['pendingBookings'] ??
                      responseData['items'] ??
                      responseData['results'] ??
                      responseData['data']
                : null,
          );
    allRequests.assignAll(
      bookings
          .whereType<Map>()
          .map((data) {
            final booking = WorkerBookingModel.fromMap(data);
            return RequestItemModel(
              bookingId: booking.id,
              title: booking.title,
              requestId: booking.requestId,
              date: booking.displayRequestedOn,
              startDate: booking.displayStartDate,
              amount: _money(booking.amount),
              address: booking.address,
              status: _requestStatus(booking.status),
            );
          })
          .where(
            (request) =>
                !WorkerBookingApiServices.acceptedBookingIds.contains(
                  request.bookingId,
                ) &&
                !WorkerBookingApiServices.rejectedBookingIds.contains(
                  request.bookingId,
                ),
          ),
    );
    allRequests.refresh();
    Get.log('[REQUEST_POLL] Requests tab received=${allRequests.length}');
  }

  Future<void> acceptRequest(RequestItemModel request) async {
    if (request.bookingId.isEmpty) return;
    final Map response = await WorkerBookingApiServices.acceptBooking(
      request.bookingId,
    );
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    WorkerBookingApiServices.markAccepted(request.bookingId);
    allRequests.removeWhere((item) => item.bookingId == request.bookingId);
    Get.snackbar('Request Accepted', 'You accepted ${request.title} request');
  }

  Future<void> rejectRequest(RequestItemModel request) async {
    if (request.bookingId.isEmpty) return;
    final Map response = await WorkerBookingApiServices.rejectBooking(
      request.bookingId,
    );
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    WorkerBookingApiServices.markRejected(request.bookingId);
    allRequests.removeWhere((item) => item.bookingId == request.bookingId);
    Get.snackbar('Request Rejected', 'You rejected ${request.title} request');
  }

  void removePendingBooking(String bookingId) {
    allRequests.removeWhere((item) => item.bookingId == bookingId);
  }

  Future<void> getWorkerHistory(RequestFilterTab filter) async {
    final String? status = switch (filter) {
      RequestFilterTab.accepted => 'ACCEPTED',
      RequestFilterTab.rejected => 'REJECTED',
      RequestFilterTab.pending => 'PENDING',
      _ => null,
    };
    if (status == null) return;

    final int request = ++_historyRequest;
    isHistoryLoading.value = true;
    final Map response = await WorkerBookingApiServices.getWorkerHistory(
      status,
    );
    if (request != _historyRequest) return;
    isHistoryLoading.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }

    final dynamic responseData = response['data'];
    final List bookings = responseData is List
        ? responseData
        : apiPeramList(
            responseData is Map
                ? responseData['bookings'] ??
                      responseData['history'] ??
                      responseData['items'] ??
                      responseData['results'] ??
                      responseData['data']
                : null,
          );
    allRequests.assignAll(
      bookings.whereType<Map>().map((data) {
        final booking = WorkerBookingModel.fromMap(data);
        return RequestItemModel(
          bookingId: booking.id,
          title: booking.title,
          requestId: booking.requestId,
          date: booking.displayRequestedOn,
          startDate: booking.displayStartDate,
          amount: _money(booking.amount),
          address: booking.address,
          status: _requestStatus(booking.status),
        );
      }),
    );
  }

  WorkerRequestStatus _requestStatus(String status) {
    if (status == 'ACCEPTED') return WorkerRequestStatus.accepted;
    if (status == 'REJECTED') return WorkerRequestStatus.rejected;
    return WorkerRequestStatus.newRequest;
  }

  String _money(String value) => value.startsWith('₹') ? value : '₹$value';
}
