import 'package:constructo_worker/screens/bottomnavbar/widgets/request_card_widget.dart';
import 'package:get/get.dart';

class RequestDetailsController extends GetxController {
  final title = "Painting Work".obs;
  final requestId = "WRK-54544-5485".obs;
  final date = "24 may 2026 10:15 AM".obs;
  final startDate = "-- -- ----".obs;
  final paymentType = "After Work Completion".obs;
  final amount = "₹54,874".obs;

  final customerName = "Rahul Sharma".obs;
  final customerEmail = "rahul@gmail.com".obs;
  final customerNo = "909090909090".obs;
  final address = "Near Union Bank Boring Road Patna Bihar 208547".obs;

  final workType = "Interior Wall Painting".obs;
  final estimatedDuration = "3 Days".obs;
  final preferredDateTime = "22 May 2026, 9:00 AM".obs;
  final workDescription = "2 BHK flat - Full wall painting including primer and 2 coar.".obs;

  final subtotal = "₹256,565".obs;
  final discount = "-₹50,00".obs;
  final grandTotal = "₹248746".obs;

  final status = WorkerRequestStatus.newRequest.obs;

  void acceptRequest() {
    Get.snackbar("Request Accepted", "You accepted Painting Work request");
  }

  void rejectRequest() {
    Get.snackbar("Request Rejected", "You rejected Painting Work request");
  }

  void openMap() {
    Get.snackbar("Map Location", "Opening location on map...");
  }
}
