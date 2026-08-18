import 'package:constructo_worker/networking/api/endpoints/worker_booking_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/routes/arguments.dart';
import 'package:constructo_worker/routes/route_arguments.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/widgets/request_card_widget.dart';
import 'package:constructo_worker/screens/request_details/request_details_model.dart';
import 'package:constructo_worker/utils/url_launchar_methods.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RequestDetailsController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isAccepting = false.obs;
  final RxBool isRejecting = false.obs;
  final RxString bookingId = ''.obs;
  late final String routeStatus;
  final title = ''.obs;
  final requestId = ''.obs;
  final date = ''.obs;
  final startDate = "-- -- ----".obs;
  final paymentType = "After Work Completion".obs;
  final amount = "₹0".obs;

  final customerName = ''.obs;
  final customerEmail = ''.obs;
  final customerNo = ''.obs;
  final address = ''.obs;

  final workType = ''.obs;
  final estimatedDuration = '--'.obs;
  final preferredDateTime = '--'.obs;
  final workDescription = ''.obs;

  final subtotal = "₹0".obs;
  final discount = "₹0".obs;
  final grandTotal = "₹0".obs;

  final status = WorkerRequestStatus.newRequest.obs;

  @override
  void onInit() {
    super.onInit();
    bookingId.value = RouteArguments.getOrDefault<String>(Arguments.id, '');
    routeStatus = RouteArguments.getOrDefault<String>(
      'status',
      '',
    ).toUpperCase();
    if (bookingId.value.isNotEmpty) {
      getBookingDetails();
    } else {
      isLoading.value = false;
    }
  }

  Future<void> getBookingDetails() async {
    isLoading.value = true;
    final Map response = await WorkerBookingApiServices.getBookingDetails(
      bookingId.value,
    );
    isLoading.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    final dynamic responseData = response['data'];
    final Map data = responseData is Map
        ? apiPeramMap(responseData['booking'] ?? responseData)
        : <String, dynamic>{};
    Get.log('[REQUEST_DETAILS] dateFields=${_dateFields(data)}');
    _setBookingData(WorkerBookingModel.fromMap(data));
  }

  Map<String, dynamic> _dateFields(dynamic value, [String path = '']) {
    final result = <String, dynamic>{};
    if (value is Map) {
      for (final entry in value.entries) {
        final key = entry.key.toString();
        final currentPath = path.isEmpty ? key : '$path.$key';
        final normalized = key.toLowerCase();
        if (normalized.contains('date') ||
            normalized.contains('time') ||
            normalized.contains('schedule') ||
            normalized.contains('start')) {
          result[currentPath] = entry.value;
        }
        result.addAll(_dateFields(entry.value, currentPath));
      }
    } else if (value is List) {
      for (var index = 0; index < value.length; index++) {
        result.addAll(_dateFields(value[index], '$path[$index]'));
      }
    }
    return result;
  }

  void _setBookingData(WorkerBookingModel booking) {
    title.value = booking.title;
    requestId.value = booking.requestId;
    date.value = _formatDate(booking.requestedOn, includeTime: true);
    startDate.value = _formatDate(booking.startDate);
    paymentType.value = booking.paymentType;
    amount.value = _money(booking.amount);
    customerName.value = booking.customerName;
    customerEmail.value = booking.customerEmail;
    customerNo.value = booking.customerPhone;
    address.value = booking.address;
    workType.value = booking.workType;
    estimatedDuration.value = booking.estimatedDuration;
    preferredDateTime.value = _formatDate(
      booking.preferredDateTime,
      includeTime: true,
    );
    workDescription.value = booking.description;
    subtotal.value = _money(booking.subtotal);
    discount.value = _money(booking.discount);
    grandTotal.value = _money(booking.amount);
    const acceptedStatuses = <String>{
      'ACCEPTED',
      'CONFIRMED',
      'ASSIGNED',
      'IN_PROGRESS',
      'ONGOING',
      'COMPLETED',
    };
    status.value =
        routeStatus == 'ACCEPTED' ||
            WorkerBookingApiServices.acceptedBookingIds.contains(booking.id) ||
            acceptedStatuses.contains(booking.status)
        ? WorkerRequestStatus.accepted
        : routeStatus == 'REJECTED' ||
              WorkerBookingApiServices.rejectedBookingIds.contains(
                booking.id,
              ) ||
              booking.status == 'REJECTED' ||
              booking.status == 'CANCELLED'
        ? WorkerRequestStatus.rejected
        : WorkerRequestStatus.newRequest;
  }

  String _money(String value) => value.startsWith('₹') ? value : '₹$value';

  String _formatDate(String value, {bool includeTime = false}) {
    final String rawValue = value.trim();
    if (rawValue.isEmpty ||
        rawValue == '--' ||
        rawValue == '-- -- ----' ||
        rawValue == 'Not provided' ||
        RegExp(r'^[0:\.\-\s]+$').hasMatch(rawValue)) {
      return 'Not provided';
    }
    final DateTime? parsed = DateTime.tryParse(rawValue)?.toLocal();
    if (parsed == null) {
      if (!includeTime) {
        return rawValue.split('T').first.split(' ').first;
      }
      return rawValue;
    }
    return DateFormat(
      includeTime ? 'dd MMM yyyy, hh:mm a' : 'dd MMM yyyy',
    ).format(parsed);
  }

  Future<void> acceptRequest() async {
    if (isAccepting.value || bookingId.value.isEmpty) return;
    isAccepting.value = true;
    final Map response = await WorkerBookingApiServices.acceptBooking(
      bookingId.value,
    );
    isAccepting.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    WorkerBookingApiServices.markAccepted(bookingId.value);
    status.value = WorkerRequestStatus.accepted;
    if (Get.isRegistered<Bnb3HomeController>()) {
      await Get.find<Bnb3HomeController>().getPendingBookings();
    }
    Get.snackbar("Request Accepted", "You accepted ${title.value} request");
  }

  Future<void> rejectRequest() async {
    if (isRejecting.value || bookingId.value.isEmpty) return;
    isRejecting.value = true;
    final Map response = await WorkerBookingApiServices.rejectBooking(
      bookingId.value,
    );
    isRejecting.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    WorkerBookingApiServices.markRejected(bookingId.value);
    status.value = WorkerRequestStatus.rejected;
    if (Get.isRegistered<Bnb3HomeController>()) {
      await Get.find<Bnb3HomeController>().getPendingBookings(
        showLoading: false,
      );
    }
    if (Get.isRegistered<Bnb2MaterialController>(tag: 'requests')) {
      Get.find<Bnb2MaterialController>(
        tag: 'requests',
      ).removePendingBooking(bookingId.value);
    }
    Get.snackbar("Request Rejected", "You rejected ${title.value} request");
  }

  Future<void> openMap() async {
    final String bookingAddress = address.value.trim();
    if (bookingAddress.isEmpty) {
      Get.snackbar('Map Location', 'Address not available');
      return;
    }
    final Uri mapUrl = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': bookingAddress,
    });
    await UrlLaunchMethods.launchStringINAppOrBrowser(mapUrl.toString());
  }
}
