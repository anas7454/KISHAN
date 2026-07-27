String maskedPhoneNumber(String phoneNumber) {
  if (phoneNumber.length < 4) return phoneNumber;
  return '******${phoneNumber.substring(phoneNumber.length - 4)}';
}
