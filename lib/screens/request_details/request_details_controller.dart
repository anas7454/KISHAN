import 'package:constructo_worker/networking/api/endpoints/worker_booking_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/routes/arguments.dart';
import 'package:constructo_worker/routes/route_arguments.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/widgets/request_card_widget.dart';
import 'package:constructo_worker/screens/request_details/request_details_model.dart';
import 'package:get/get.dart';

class RequestDetailsController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isAccepting = false.obs;
  final RxString bookingId = ''.obs;
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

  @override
  void onInit() {
    super.onInit();
    bookingId.value = RouteArguments.getOrDefault<String>(Arguments.id, '');
    if (bookingId.value.isNotEmpty) getBookingDetails();
  }

  Future<void> getBookingDetails() async {
    isLoading.value = true;
    final Map response =
        await WorkerBookingApiServices.getBookingDetails(bookingId.value);
    isLoading.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    final dynamic responseData = response['data'];
    final Map data = responseData is Map
        ? apiPeramMap(responseData['booking'] ?? responseData)
        : <String, dynamic>{};
    _setBookingData(WorkerBookingModel.fromMap(data));
  }

  void _setBookingData(WorkerBookingModel booking) {
    title.value = booking.title;
    requestId.value = booking.requestId;
    date.value = booking.requestedOn;
    startDate.value = booking.startDate;
    paymentType.value = booking.paymentType;
    amount.value = _money(booking.amount);
    customerName.value = booking.customerName;
    customerEmail.value = booking.customerEmail;
    customerNo.value = booking.customerPhone;
    address.value = booking.address;
    workType.value = booking.workType;
    estimatedDuration.value = booking.estimatedDuration;
    preferredDateTime.value = booking.preferredDateTime;
    workDescription.value = booking.description;
    subtotal.value = _money(booking.subtotal);
    discount.value = _money(booking.discount);
    grandTotal.value = _money(booking.amount);
    status.value = booking.status == 'ACCEPTED'
        ? WorkerRequestStatus.accepted
        : booking.status == 'REJECTED'
            ? WorkerRequestStatus.rejected
            : WorkerRequestStatus.newRequest;
  }

  String _money(String value) => value.startsWith('₹') ? value : '₹$value';

  Future<void> acceptRequest() async {
    if (isAccepting.value || bookingId.value.isEmpty) return;
    isAccepting.value = true;
    final Map response =
        await WorkerBookingApiServices.acceptBooking(bookingId.value);
    isAccepting.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    status.value = WorkerRequestStatus.accepted;
    if (Get.isRegistered<Bnb3HomeController>()) {
      await Get.find<Bnb3HomeController>().getPendingBookings();
    }
    Get.snackbar("Request Accepted", "You accepted ${title.value} request");
  }

  void rejectRequest() {
    Get.snackbar("Request Rejected", "You rejected Painting Work request");
  }

  void openMap() {
    Get.snackbar("Map Location", "Opening location on map...");
  }
}
