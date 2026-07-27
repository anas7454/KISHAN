import 'package:constructo_worker/networking/extensions/api_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final RegExp _emailPattern = RegExp(
  r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@'
  r'((\[[0-9]{1,3}(\.[0-9]{1,3}){3}\])|'
  r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
);

bool _isEmpty(String? value) => value == null || value.isEmpty;

String _text(String? value) => value ?? '';

String? _required(String? value, String message) {
  return _isEmpty(value) ? message : null;
}

String? _validateEmailFormat(String value) {
  if (!_emailPattern.hasMatch(value)) {
    return 'Invalid Email'.tr;
  }

  final String domain = value.substring(value.lastIndexOf('.') + 1);
  final String domainName = value.substring(value.lastIndexOf('@') + 1);
  final String provider = domainName.split('.').first;

  if (domain.length < 2 || provider.length < 2) {
    return 'Invalid Email'.tr;
  }

  return null;
}

// General

String? validaterequired(String? value) {
  return _required(value, 'Required'.tr);
}

String? validateAmount(String? value) {
  return _required(value, 'Amount is required'.tr);
}

String? validateTime(String? value) {
  return _required(value, 'Time is Required'.tr);
}

String? validateSubject(String? value) {
  return _required(value, 'Subject is Required'.tr);
}

String? validateTitle(String? value) {
  return _required(value, 'Title is required'.tr);
}

String? validateMessage(String? value) {
  return _required(value, 'Message is required'.tr);
}

String? validateLocation(String? value) {
  return _required(value, 'Location is required');
}

String? validateDescription(String? value) {
  return _required(value, 'Description is Required');
}

// Contact details

String? validateWhatsppNumberIndia(String? value) {
  if (_isEmpty(value)) {
    return 'Whatsapp number is required.'.tr;
  }
  if (value!.length != 10) {
    return 'Whatsapp number must be 10 digits long.';
  }
  return null;
}

String? validateMobileIndia(String? value) {
  if (_isEmpty(value)) {
    return 'Mobile number is required.'.tr;
  }
  if (value!.length != 10) {
    return 'Mobile number must be 10 digits long.';
  }
  return null;
}

String? validateInadiaMobile(String? value) {
  if (_isEmpty(value)) {
    return 'Phone Number is required'.tr;
  }
  if (value!.length != 10) {
    return 'Phone Number must equal to 10 digit';
  }
  return null;
}

String? validateEmail(String? value) {
  if (_isEmpty(value)) {
    return 'Email is required'.tr;
  }
  return _validateEmailFormat(value!);
}

String? validateEmailOptional(String? value) {
  if (_isEmpty(value)) {
    return null;
  }
  return _validateEmailFormat(value!);
}

// User and business details

String? validateName(String? value) {
  if (_isEmpty(value)) {
    return 'Name is required'.tr;
  }
  if (value!.length < 2) {
    return 'Name required at least 2 characters';
  }
  return null;
}

String? validateFirstName(String? value) {
  if (_isEmpty(value)) {
    return 'First name is required'.tr;
  }
  if (value!.length < 2) {
    return 'First Name required at least 2 characters';
  }
  return null;
}

String? validateLastName(String? value) {
  if (_isEmpty(value)) {
    return 'Last name is required'.tr;
  }
  if (value!.length < 2) {
    return 'Last Name required at least 2 characters';
  }
  return null;
}

String? validateUserName(String? value) {
  if (_isEmpty(value)) {
    return 'User name is required'.tr;
  }
  if (value!.length < 6) {
    return 'User Name required at least 6 characters';
  }
  return null;
}

String? validatedesignation(String? value) {
  if (_isEmpty(value)) {
    return 'Required.'.tr;
  }
  if (value!.length > 120) {
    return 'designation length must be less than 120 characters.';
  }
  return null;
}

String? validatedesiredTenureMonths(String? value) {
  if (_isEmpty(value)) {
    return 'Required.'.tr;
  }
  if (value!.length > 84) {
    return 'DesiredTenureMonths must be less than 84';
  }
  return null;
}

String? validatebusinessVintageYears(String? value) {
  if (_isEmpty(value)) {
    return 'Required.'.tr;
  }
  if (apiPeramNumber(_text(value)) > 50) {
    return 'years must be less than or equal to 50';
  }
  return null;
}

String? validateInviteCode(String? value) {
  return _required(value, 'Invite Code is Required.');
}

// Passwords

String? validateNewPassword(String? value) {
  return _required(value, 'New password is required');
}

String? validateOldPassword(String? value) {
  return _required(value, 'Old password is required');
}

String? validatePasswordOnlyRequired(String? value) {
  return _required(value, 'Password is required');
}

String? validatePassword(String? value) {
  if (_isEmpty(value)) {
    return 'Password is required';
  }

  final String password = value!;
  if (password.length < 6) {
    return 'Password should be 6 characters long';
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return 'At least 1 small alphabet is required';
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return 'At least 1 capital alphabet is required';
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return 'At least 1 numeric character is required';
  }
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'At least 1 Special character is required';
  }
  return null;
}

String? validateCnfPassword(String value1, String value2) {
  if (value1.isEmpty || value2.isEmpty) {
    return 'Confirm Password is Required';
  }
  if (value1 != value2) {
    return 'Passwords do not match';
  }
  return null;
}

// Events and media

String? validateEventName(String? value) {
  return _required(value, 'Event Name is Required');
}

String? validatePostName(String? value) {
  return _required(value, 'Post Name is Required');
}

String? validateselectPhoto(String? value) {
  return _required(value, 'Proof of Payment is Required.');
}

String? validateEventPhoto(String? value) {
  return _required(value, 'Event Photo is Required.');
}

String? validatePhoto(String? value) {
  return _required(value, 'Photo is Required.');
}

String? validateTag(String? value) {
  return _required(value, 'Tag is Required.');
}

// Date of birth

String? validateDate(String? value) {
  return _required(value, 'Date is Required');
}

String? validateDoBRequired(String? value) {
  return _required(value, 'Date of Birth is Required');
}

String? validateDateValidDob18year(String? value) {
  if (_isEmpty(value)) {
    return 'Required';
  }

  final String date = value!;
  if (date.length != 10) {
    return 'Incorrect DOB';
  }
  if (!isDateValid(date, 'dd/MM/yyyy')) {
    return 'Invalid date';
  }

  final DateTime birthDate = DateTime.parse(
    DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(date)),
  );

  if (calculateAge(birthDate) < 18) {
    return 'You must be at least 18 year old';
  }
  return null;
}

bool isDateValid(String input, String format) {
  try {
    DateFormat(format).parseStrict(input);
    return true;
  } catch (_) {
    return false;
  }
}

int calculateAge(DateTime birthDate) {
  final DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;

  final bool birthdayIsPending =
      birthDate.month > currentDate.month ||
      (birthDate.month == currentDate.month && birthDate.day > currentDate.day);

  if (birthdayIsPending) {
    age--;
  }
  return age;
}

// Address

String? validateAppartmentNo(String? value) {
  return _required(value, 'Appartment no. is Required.');
}

String? validateBuilding(String? value) {
  return _required(value, 'Building is Required.');
}

String? validateStreet(String? value) {
  return _required(value, 'Street is Required.');
}

String? validateAddressName(String? value) {
  if (_isEmpty(value)) {
    return 'Required.';
  }
  if (value!.length < 10) {
    return 'Address required at least 10 Charecter';
  }
  return null;
}

// Vehicle and payment

String? validateCarRegNumber(String? value) {
  return _required(value, 'Car Registration Number is Required.');
}

String? validateSellingPrice(String? value) {
  return _required(value, 'Selling Price is Required.');
}

String? validateOfferPrice(String? value) {
  return _required(value, 'Offer Price is Required.');
}

String? validateCarkmdriven(String? value) {
  return _required(value, 'Car Km Driven is Required.');
}

String? validateWalletAddress(String? value) {
  if (_isEmpty(value)) {
    return 'Required';
  }
  if (value!.length != 42) {
    return 'Invalid wallet address';
  }
  return null;
}

String? validateOtp(String? value) {
  return _required(value, 'Otp is Required.');
}
