String getAddreeLast4digitText(String fullText) {
  if (fullText.isEmpty) {
    return '-';
  }
  if (fullText.length >= 8) {
    final firstFour = fullText.substring(0, 4);
    final lastFour = fullText.substring(fullText.length - 4);
    return '$firstFour...$lastFour';
  }
  return fullText;
}

String getShortTextFromLongText(String fullText, {int length = 12}) {
  if (fullText.length >= 12) {
    final firstFour = fullText.substring(0, 12);
    return '$firstFour...';
  }
  return fullText;
}

String shortNameConverted(String fullName) {
  final nameParts = fullName.split(' ');

  if (nameParts.length > 1) {
    final firstInitial = nameParts[0][0];
    final lastName = nameParts[1];
    return '$firstInitial $lastName';
  }

  return fullName;
}

String getListToTextString(List<String> dataList) {
  var teamListString = '';

  for (var i = 0; i < dataList.length; i++) {
    if (teamListString == '') {
      teamListString = dataList[i];
    } else {
      teamListString = '$teamListString, ${dataList[i]}';
    }
  }

  return teamListString;
}

String convertToOrdinal(String value) {
  final number = int.tryParse(value) ?? 0;
  if (number == 0) return value;

  final tens = number % 100;
  if (tens >= 11 && tens <= 13) {
    return '${number}th';
  }

  switch (number % 10) {
    case 1:
      return '${number}st';
    case 2:
      return '${number}nd';
    case 3:
      return '${number}rd';
    default:
      return '${number}th';
  }
}

String spaceRemovePlusAdd(String? value) {
  if (value == null) {
    return '';
  }
  return value.trim().replaceAll(' ', '+');
}

String viewOnly4digit(String value) {
  if (value.length <= 4) return value;

  final first4 = value.substring(0, 4);
  final stars = '*' * (value.length - 4);

  return '$first4$stars';
}

String getCountWithCostak(String count) {
  if (count == '' || count == '0') return '';
  return '($count)';
}

String getYearWithComma(String year) {
  if (year == '' || year.isEmpty) return year;
  return '$year,';
}
