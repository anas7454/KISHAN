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
  int _historyRequest = 0;

  final RxList<RequestItemModel> allRequests = <RequestItemModel>[
    // New Request cards (shown in Requests tab)
    RequestItemModel(
      title: "Painting Work",
      requestId: "WRK-54544-5485",
      date: "24 may 2026 10:15 AM",
      amount: "₹54,874",
      address: "Near Union Bank Boring Road Patna Bihar 208547",
      status: WorkerRequestStatus.newRequest,
    ),
    RequestItemModel(
      title: "Painting Work",
      requestId: "WRK-54544-5485",
      date: "24 may 2026 10:15 AM",
      amount: "₹54,874",
      address: "Near Union Bank Boring Road Patna Bihar 208547",
      status: WorkerRequestStatus.newRequest,
    ),
    // Accepted card (shown in My Work tab)
    RequestItemModel(
      title: "Painting Work",
      requestId: "WRK-54544-5485",
      date: "24 may 2026 10:15 AM",
      startDate: "25 may 2026 10:15 AM",
      amount: "₹54,874",
      address: "Near Union Bank Boring Road Patna Bihar 208547",
      status: WorkerRequestStatus.accepted,
    ),
    // Rejected card (shown in My Work tab)
    RequestItemModel(
      title: "Painting Work",
      requestId: "WRK-54544-5485",
      date: "24 may 2026 10:15 AM",
      amount: "₹54,874",
      address: "Near Union Bank Boring Road Patna Bihar 208547",
      status: WorkerRequestStatus.rejected,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    if (isMyWork) {
      selectedFilter.value = RequestFilterTab.accepted;
      getWorkerHistory(RequestFilterTab.accepted);
    } else {
      selectedFilter.value = RequestFilterTab.newReq;
    }
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
          date: booking.requestedOn,
          startDate: booking.startDate,
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
