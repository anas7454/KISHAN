import 'package:constructo/networking/extensions/api_helper.dart';

num getPercentRemaingAmount(num amount, num persentFees) {
  return apiPeramDouble(
    ((amount * (100 - persentFees)) / 100).toStringAsFixed(2),
  );
}

num getPercentOfAmount(num amount, num totalAmount) {
  if (totalAmount < amount) {
    totalAmount = amount;
  }

  if (amount == 0 && totalAmount == 0) {
    return 0;
  }

  num persent = apiPeramDouble(
    (((amount * 100) / totalAmount).toStringAsFixed(2)),
  );

  return persent;
}

num formatNumber2Decimal(String number) {
  // 20.8888 hai to 20.88 ayega 20.89 nhi
  // Convert safely to double
  double? value = double.tryParse(number);
  if (value == null || value.isNaN) return 0;

  // Truncate (not round) to 2 decimals
  double truncated = (value * 100).truncateToDouble() / 100;

  // Convert to string, remove trailing zeros and decimal if not needed
  String result = truncated.toStringAsFixed(2);
  result = result.replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');

  return apiPeramNumber(result);
}

// Function to convert numbers
num removeZerofromNumber(double number) {
  if (number == number.toInt()) {
    // If the number has no fractional part, return as int
    return number.toInt();
  } else {
    // Otherwise, return the number as is (double)
    return number;
  }
}
