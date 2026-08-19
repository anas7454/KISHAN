import 'package:constructo_worker/networking/api/endpoints/worker_booking_api_services.dart';
import 'package:constructo_worker/networking/api/endpoints/skills_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/routes/arguments.dart';
import 'package:constructo_worker/routes/route_arguments.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/widgets/request_card_widget.dart';
import 'package:constructo_worker/screens/request_details/request_details_model.dart';
import 'package:constructo_worker/utils/url_launchar_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RequestDetailsController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isAccepting = false.obs;
  final RxBool isRejecting = false.obs;
  final RxBool isWorkflowLoading = false.obs;
  final RxString workflowStatus = 'PENDING'.obs;
  final RxString bookingId = ''.obs;
  final RxString skillId = ''.obs;
  final RxList<Map<String, String>> additionalSkillServices =
      <Map<String, String>>[].obs;
  final RxBool isAdditionalServicesLoading = false.obs;
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
    final booking = WorkerBookingModel.fromMap(data);
    Get.log(
      '[REQUEST_DETAILS_STATUS] '
      'status=${data['status']}, '
      'bookingStatus=${data['bookingStatus']}, '
      'workStatus=${data['workStatus']}, '
      'workerStatus=${data['workerStatus']}, '
      'parsed=${booking.status}',
    );
    _setBookingData(booking);
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
    skillId.value = apiPeramString(
      booking.rawData['skillId'] ?? apiPeramMap(booking.rawData['skill'])['id'],
    );
    workflowStatus.value = _resolveWorkflowStatus(booking);
    const acceptedStatuses = <String>{
      'ACCEPTED',
      'CONFIRMED',
      'ASSIGNED',
      'IN_PROGRESS',
      'ONGOING',
      'COMPLETED',
      'ARRIVED',
      'INSPECTION',
      'INSPECTION_STARTED',
      'STARTED',
      'WORK_STARTED',
      'ADDITIONAL_SERVICE_PENDING',
      'ADDITIONAL_SERVICES_PENDING',
      'ESTIMATE_PENDING',
      'AWAITING_APPROVAL',
      'ADDITIONAL_SERVICE_APPROVED',
      'ADDITIONAL_SERVICES_APPROVED',
      'ADDITIONAL_SKILL_SERVICES_PENDING',
      'ADDITIONAL_SKILL_SERVICES_APPROVED',
      'ADDITIONAL_SERVICES_ADDED',
      'ADDITIONAL_SERVICE_REJECTED',
      'ADDITIONAL_SERVICES_REJECTED',
      'ESTIMATE_APPROVED',
      'ESTIMATE_REJECTED',
    };
    status.value =
        routeStatus == 'ACCEPTED' ||
            WorkerBookingApiServices.acceptedBookingIds.contains(booking.id) ||
            acceptedStatuses.contains(workflowStatus.value)
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

  String _resolveWorkflowStatus(WorkerBookingModel booking) {
    final Map<String, dynamic> data = booking.rawData;
    final String lifecycle = apiPeramString(
      data['bookingStatus'] ??
          data['status'] ??
          data['workStatus'] ??
          data['jobStatus'],
    ).toUpperCase();
    final String workerStatus = apiPeramString(
      data['workerStatus'] ??
          data['workerResponseStatus'] ??
          data['assignmentStatus'],
    ).toUpperCase();

    final String resolved = switch (lifecycle) {
      'WORKER_ARRIVED' => 'ARRIVED',
      'INSPECTING' || 'UNDER_INSPECTION' => 'INSPECTION',
      'WORK_IN_PROGRESS' => 'IN_PROGRESS',
      'WORK_COMPLETED' => 'COMPLETED',
      '' || 'PENDING' when workerStatus == 'ACCEPTED' => 'ACCEPTED',
      _ => lifecycle.isNotEmpty ? lifecycle : workerStatus,
    };
    Get.log(
      '[REQUEST_WORKFLOW] lifecycle=$lifecycle, '
      'workerStatus=$workerStatus, resolved=$resolved',
    );
    return resolved.isEmpty ? booking.status : resolved;
  }

  String get workflowActionLabel {
    switch (workflowStatus.value) {
      case 'ACCEPTED':
      case 'CONFIRMED':
      case 'ASSIGNED':
        return 'Mark Arrived';
      case 'ARRIVED':
        return 'Complete Work';
      case 'INSPECTION':
      case 'INSPECTION_STARTED':
        return 'Complete Work';
      case 'ADDITIONAL_SERVICE_PENDING':
      case 'ESTIMATE_PENDING':
      case 'AWAITING_APPROVAL':
      case 'ADDITIONAL_SERVICES_PENDING':
      case 'ADDITIONAL_SKILL_SERVICES_PENDING':
      case 'ADDITIONAL_SERVICES_ADDED':
        return 'Waiting for Customer Approval';
      case 'ADDITIONAL_SERVICE_APPROVED':
      case 'ADDITIONAL_SERVICES_APPROVED':
      case 'ADDITIONAL_SKILL_SERVICES_APPROVED':
      case 'ESTIMATE_APPROVED':
        return 'Start Work';
      case 'ADDITIONAL_SERVICE_REJECTED':
      case 'ADDITIONAL_SERVICES_REJECTED':
      case 'ESTIMATE_REJECTED':
        return 'Add Estimate to Continue';
      case 'IN_PROGRESS':
      case 'ONGOING':
      case 'STARTED':
      case 'WORK_STARTED':
        return 'Complete Work';
      case 'COMPLETED':
        return 'Work Completed';
      default:
        return '';
    }
  }

  bool get canAddAdditionalServices => false;

  bool get workflowActionEnabled =>
      workflowActionLabel.isNotEmpty &&
      workflowActionLabel != 'Waiting for Customer Approval' &&
      workflowActionLabel != 'Work Completed' &&
      workflowActionLabel != 'Add Estimate to Continue';

  Future<void> performWorkflowAction() async {
    if (isWorkflowLoading.value || !workflowActionEnabled) return;
    isWorkflowLoading.value = true;
    Map response;
    final String current = workflowStatus.value;
    late final String successMessage;
    late final String expectedStatus;
    if (<String>{'ACCEPTED', 'CONFIRMED', 'ASSIGNED'}.contains(current)) {
      response = await WorkerBookingApiServices.markArrived(bookingId.value);
      successMessage = 'Marked Arrived Successfully';
      expectedStatus = 'ARRIVED';
    } else if (<String>{
      'ADDITIONAL_SERVICE_APPROVED',
      'ADDITIONAL_SERVICES_APPROVED',
      'ADDITIONAL_SKILL_SERVICES_APPROVED',
      'ESTIMATE_APPROVED',
    }.contains(current)) {
      response = await WorkerBookingApiServices.startWork(bookingId.value);
      successMessage = 'Work Started Successfully';
      expectedStatus = 'IN_PROGRESS';
    } else {
      response = await WorkerBookingApiServices.completeWork(bookingId.value);
      successMessage = 'Work Completed Successfully';
      expectedStatus = 'COMPLETED';
    }
    isWorkflowLoading.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    _showSuccessSnackbar(successMessage);
    workflowStatus.value = expectedStatus;
    await getBookingDetails();
    if (workflowStatus.value == current) {
      workflowStatus.value = expectedStatus;
    }
  }

  Future<bool> completeWorkWithComment(String comment) async {
    final String trimmedComment = comment.trim();
    if (trimmedComment.isEmpty || isWorkflowLoading.value) return false;
    isWorkflowLoading.value = true;
    final Map response;
    try {
      response = await WorkerBookingApiServices.completeWork(
        bookingId.value,
        comment: trimmedComment,
      );
    } finally {
      isWorkflowLoading.value = false;
    }
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return false;
    }
    workflowStatus.value = 'COMPLETED';
    _showSuccessSnackbar('Work Completed Successfully');
    await getBookingDetails();
    return true;
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xff16A34A),
      colorText: const Color(0xffffffff),
      icon: const Icon(Icons.check_circle_rounded, color: Color(0xffffffff)),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: const Duration(seconds: 2),
    );
  }

  Future<bool> submitAdditionalServices(
    List<Map<String, dynamic>> items,
  ) async {
    if (isWorkflowLoading.value || items.isEmpty) return false;
    isWorkflowLoading.value = true;
    final Map response =
        await WorkerBookingApiServices.addAdditionalSkillServices(
          bookingId.value,
          <String, dynamic>{
            'skillServiceIds': items
                .map((item) => item['skillServiceId'])
                .whereType<String>()
                .where((id) => id.isNotEmpty)
                .toList(),
            'services': items,
          },
        );
    isWorkflowLoading.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return false;
    }
    Get.snackbar(
      'Estimate Sent',
      'Customer approval is required before starting work',
    );
    const String pendingStatus = 'AWAITING_APPROVAL';
    workflowStatus.value = pendingStatus;
    await getBookingDetails();
    if (<String>{
      'INSPECTION',
      'INSPECTION_STARTED',
    }.contains(workflowStatus.value)) {
      workflowStatus.value = pendingStatus;
    }
    return true;
  }

  Future<void> loadAdditionalSkillServices() async {
    if (skillId.value.isEmpty || isAdditionalServicesLoading.value) return;
    isAdditionalServicesLoading.value = true;
    final Map response = await SkillsApiServices.getServices(skillId.value);
    isAdditionalServicesLoading.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    final dynamic rawData = response['data'];
    final List rawServices = rawData is List
        ? rawData
        : apiPeramList(
            rawData is Map
                ? rawData['services'] ?? rawData['items'] ?? rawData['data']
                : null,
          );
    additionalSkillServices.assignAll(
      rawServices
          .whereType<Map>()
          .map(
            (service) => <String, String>{
              'id': apiPeramString(
                service['id'] ?? service['skillServiceId'] ?? service['_id'],
              ),
              'name': apiPeramString(
                service['name'] ?? service['serviceName'] ?? service['title'],
                initialValue: 'Service',
              ),
            },
          )
          .where((service) => service['id']!.isNotEmpty),
    );
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
    if (isAccepting.value || isRejecting.value || bookingId.value.isEmpty)
      return;
    isAccepting.value = true;
    final Map response;
    try {
      response = await WorkerBookingApiServices.acceptBooking(bookingId.value);
    } finally {
      isAccepting.value = false;
    }
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    WorkerBookingApiServices.markAccepted(bookingId.value);
    status.value = WorkerRequestStatus.accepted;
    workflowStatus.value = 'ACCEPTED';
    if (Get.isRegistered<Bnb3HomeController>()) {
      await Get.find<Bnb3HomeController>().getPendingBookings();
    }
    _showSuccessSnackbar('Request Accepted Successfully');
  }

  Future<void> rejectRequest() async {
    if (isAccepting.value || isRejecting.value || bookingId.value.isEmpty)
      return;
    isRejecting.value = true;
    final Map response;
    try {
      response = await WorkerBookingApiServices.rejectBooking(bookingId.value);
    } finally {
      isRejecting.value = false;
    }
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
