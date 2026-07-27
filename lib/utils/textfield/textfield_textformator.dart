import 'package:flutter/services.dart';

// captial text krne ke liye
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}

// DL 3C BA 6264

class CarNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Agar user backspace kar raha hai
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Remove spaces & uppercase
    String rawText = newValue.text.toUpperCase().replaceAll(RegExp(r'\s+'), '');

    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < rawText.length; i++) {
      buffer.write(rawText[i]);

      if (i == 1) buffer.write(' ');
      if (i == 3) buffer.write(' ');
      if (i == 5) buffer.write(' ');
    }

    final formattedText = buffer.toString();

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class IndianNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // backspace allow
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // sirf digits rakho
    String digits = newValue.text.replaceAll(',', '');

    // avoid crash
    if (digits.length <= 3) {
      return newValue.copyWith(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
    }

    String last3 = digits.substring(digits.length - 3);
    String rest = digits.substring(0, digits.length - 3);

    String formattedRest = rest.replaceAllMapped(RegExp(r'(\d)(?=(\d{2})+(?!\d))'), (Match m) => '${m[1]},');

    String finalText = '$formattedRest,$last3';

    return TextEditingValue(
      text: finalText,
      selection: TextSelection.collapsed(offset: finalText.length),
    );
  }
}
