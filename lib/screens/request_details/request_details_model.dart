import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:intl/intl.dart';

class WorkerBookingModel {
  WorkerBookingModel.fromMap(Map data)
    : rawData = Map<String, dynamic>.from(data) {
    final dynamic rawService = data['service'] ?? data['skillService'];
    final dynamic rawSkill = data['skill'];
    final dynamic rawCustomer =
        data['customer'] ?? data['user'] ?? data['bookedBy'];
    final dynamic rawAddress =
        data['address'] ??
        data['serviceAddress'] ??
        data['siteAddress'] ??
        data['customerAddress'] ??
        data['location'];
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
    id = apiPeramString(data['id'] ?? data['bookingId'] ?? data['_id']);
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
      _findValue(data, const <String>[
        'startDate',
        'scheduledDate',
        'scheduledAt',
        'scheduledFor',
        'preferredDateTime',
        'preferredDate',
        'preferredStartDate',
        'preferredStartDateTime',
        'scheduledStartDate',
        'serviceDate',
        'workDate',
        'appointmentDate',
        'visitDate',
        'bookingDate',
      ]),
      initialValue: 'Not provided',
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
      data['workType'] ??
          data['projectType'] ??
          data['serviceType'] ??
          service['name'] ??
          skill['name'],
      initialValue: title,
    );
    estimatedDuration = apiPeramString(
      data['estimatedDuration'] ??
          service['estimatedDuration'] ??
          data['duration'],
      initialValue: '--',
    );
    preferredDateTime = apiPeramString(
      _findValue(data, const <String>[
        'preferredDateTime',
        'preferredDate',
        'preferredStartDateTime',
        'preferredStartDate',
        'scheduledDate',
        'scheduledAt',
        'scheduledFor',
        'startDate',
        'serviceDate',
        'workDate',
        'appointmentDate',
        'visitDate',
        'bookingDate',
      ]),
      initialValue: 'Not provided',
    );
    description = apiPeramString(
      data['description'] ??
          data['workDescription'] ??
          data['siteDetails'] ??
          data['specialInstructions'] ??
          data['notes'],
    );
    subtotal = apiPeramString(data['subtotal'], initialValue: amount);
    discount = apiPeramString(data['discount'], initialValue: '0');
    status = apiPeramString(
      data['workerStatus'] ??
          data['workerResponseStatus'] ??
          data['assignmentStatus'] ??
          data['status'],
      initialValue: 'PENDING',
    ).toUpperCase();
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

  String get displayRequestedOn =>
      _formatDisplayDate(requestedOn, includeTime: true);

  String get displayStartDate => _formatDisplayDate(startDate);

  String _formatDisplayDate(String value, {bool includeTime = false}) {
    final String raw = value.trim();
    if (raw.isEmpty ||
        raw == 'Not provided' ||
        RegExp(r'^[0:\.\-\s]+$').hasMatch(raw)) {
      return 'Not provided';
    }
    final DateTime? parsed = DateTime.tryParse(raw)?.toLocal();
    if (parsed == null) {
      return includeTime ? raw : raw.split('T').first.split(' ').first;
    }
    return DateFormat(
      includeTime ? 'dd MMM yyyy, hh:mm a' : 'dd MMM yyyy',
    ).format(parsed);
  }

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

  static dynamic _findValue(dynamic value, List<String> keys) {
    if (value is Map) {
      for (final key in keys) {
        for (final entry in value.entries) {
          if (entry.key.toString().toLowerCase() == key.toLowerCase() &&
              _isUsableDateValue(entry.value)) {
            return entry.value;
          }
        }
      }
      for (final nested in value.values) {
        final dynamic result = _findValue(nested, keys);
        if (apiPeramString(result).isNotEmpty) return result;
      }
    } else if (value is List) {
      for (final nested in value) {
        final dynamic result = _findValue(nested, keys);
        if (apiPeramString(result).isNotEmpty) return result;
      }
    }
    return null;
  }

  static bool _isUsableDateValue(dynamic value) {
    final String text = apiPeramString(value);
    if (text.isEmpty) return false;
    return !RegExp(r'^[0:\.\-\s]+$').hasMatch(text);
  }
}
