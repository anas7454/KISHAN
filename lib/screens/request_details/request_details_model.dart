import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';

class WorkerBookingModel {
  WorkerBookingModel.fromMap(Map data) : rawData = Map<String, dynamic>.from(data) {
    final dynamic rawService = data['service'];
    final dynamic rawSkill = data['skill'];
    final dynamic rawCustomer = data['customer'] ?? data['user'];
    final dynamic rawAddress = data['address'] ?? data['serviceAddress'];
    final Map service = rawService is Map
        ? apiPeramMap(rawService)
        : <String, dynamic>{};
    final Map skill = rawSkill is Map
        ? apiPeramMap(rawSkill)
        : <String, dynamic>{};
    final Map customer = rawCustomer is Map
        ? apiPeramMap(rawCustomer)
        : <String, dynamic>{};
    final Map bookingAddress = rawAddress is Map
        ? apiPeramMap(rawAddress)
        : <String, dynamic>{};

    id = apiPeramString(
      data['id'] ?? data['bookingId'] ?? data['_id'],
    );
    requestId = apiPeramString(
      data['bookingNumber'] ?? data['requestId'] ?? data['code'],
      initialValue: id,
    );
    title = apiPeramString(
      data['title'] ?? data['serviceName'] ?? service['name'] ?? skill['name'],
      initialValue: 'Work Request',
    );
    requestedOn = apiPeramString(data['createdAt'] ?? data['requestedOn']);
    startDate = apiPeramString(
      data['startDate'] ?? data['scheduledDate'] ?? data['preferredDateTime'],
      initialValue: '-- -- ----',
    );
    paymentType = apiPeramString(
      data['paymentType'] ?? data['paymentMode'],
      initialValue: 'After Work Completion',
    );
    amount = apiPeramString(
      data['grandTotal'] ?? data['totalAmount'] ?? data['amount'],
      initialValue: '0',
    );
    address = _addressText(rawAddress, bookingAddress);
    customerName = apiPeramString(
      customer['name'] ?? customer['fullName'],
      initialValue: 'Customer',
    );
    customerEmail = apiPeramString(customer['email']);
    customerPhone = apiPeramString(customer['phone'] ?? customer['mobile']);
    workType = apiPeramString(
      data['workType'] ?? data['serviceType'] ?? service['name'] ?? skill['name'],
      initialValue: title,
    );
    estimatedDuration = apiPeramString(
      data['estimatedDuration'] ?? data['duration'],
      initialValue: '--',
    );
    preferredDateTime = apiPeramString(
      data['preferredDateTime'] ?? data['scheduledDate'] ?? data['startDate'],
      initialValue: '--',
    );
    description = apiPeramString(
      data['description'] ?? data['workDescription'] ?? data['notes'],
    );
    subtotal = apiPeramString(data['subtotal'], initialValue: amount);
    discount = apiPeramString(data['discount'], initialValue: '0');
    status = apiPeramString(data['status'], initialValue: 'PENDING').toUpperCase();
  }

  final Map<String, dynamic> rawData;
  late final String id;
  late final String requestId;
  late final String title;
  late final String requestedOn;
  late final String startDate;
  late final String paymentType;
  late final String amount;
  late final String address;
  late final String customerName;
  late final String customerEmail;
  late final String customerPhone;
  late final String workType;
  late final String estimatedDuration;
  late final String preferredDateTime;
  late final String description;
  late final String subtotal;
  late final String discount;
  late final String status;

  String _addressText(dynamic rawAddress, Map addressMap) {
    if (rawAddress is String) return apiPeramString(rawAddress);
    return <String>[
      apiPeramString(addressMap['addressLine1']),
      apiPeramString(addressMap['addressLine2']),
      apiPeramString(addressMap['city']),
      apiPeramString(addressMap['state']),
      apiPeramString(addressMap['pincode']),
    ].where((value) => value.isNotEmpty).join(', ');
  }
}
