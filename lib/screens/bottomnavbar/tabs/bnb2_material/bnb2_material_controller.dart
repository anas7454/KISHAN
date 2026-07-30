import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/widgets/request_card_widget.dart';
import 'package:get/get.dart';

enum RequestFilterTab { all, newReq, accepted, rejected }

class RequestItemModel {
  final String title;
  final String requestId;
  final String date;
  final String? startDate;
  final String amount;
  final String address;
  final WorkerRequestStatus status;

  RequestItemModel({
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
  final GlobalController globalController = Get.find();
  final Rx<RequestFilterTab> selectedFilter = RequestFilterTab.all.obs;

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

  List<RequestItemModel> get filteredRequests {
    switch (selectedFilter.value) {
      case RequestFilterTab.all:
        return allRequests;
      case RequestFilterTab.newReq:
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
    selectedFilter.value = filter;
  }
}
