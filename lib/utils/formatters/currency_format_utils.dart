import 'package:intl/intl.dart';

String formatCurrencyWithRupyeSymbol(num value, {bool removeSpace = false}) {
  final format = NumberFormat.currency(
    locale: 'hi_IN',
    symbol: removeSpace ? '₹' : '₹ ',
    decimalDigits: 0,
  );
  return format.format(value);
}

String formatCurrency(num value, {bool isFormate = true}) {
  if (isFormate == false) return value.toString();
  final format = NumberFormat.decimalPattern('hi_IN');
  return format.format(value);
}

String formatToLakh(num value) {
  if (value < 100000) {
    return '₹${(value / 100000).toStringAsFixed(1)} Lakh';
  }
  return '₹${(value / 100000).toStringAsFixed(2)} Lakh';
}

num convertInLakh(num value) {
  return double.parse((value / 100000).toStringAsFixed(2));
}
