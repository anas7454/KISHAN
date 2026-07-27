int getUniqueNumberDateTime() {
  return DateTime.now().microsecondsSinceEpoch;
}

int getMillSecondTimeStemp() {
  return DateTime.now().millisecondsSinceEpoch;
}

List<int> generateYearList({int startYear = 1950}) {
  final currentYear = DateTime.now().year;

  return List.generate(
    currentYear - startYear + 1,
    (index) => currentYear - index,
  );
}
