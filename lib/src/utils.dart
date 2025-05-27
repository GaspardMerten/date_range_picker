import 'package:intl/intl.dart';

/// Returns the default week days as strings (using intl).
List<String> defaultWeekDays({int lengthOfDateNames = 3, String? locale}) {
  DateFormat dateFormat;

  try {
    dateFormat = DateFormat.E(locale);
  } catch (e) {
    // If the locale is not supported, fallback to the default locale
    dateFormat = DateFormat.E();
  }

  return dateFormat.dateSymbols.WEEKDAYS
      .map((e) => e.substring(0, lengthOfDateNames))
      .toList();
}

extension ListUtils on List {
  /// Shifts the list by "amount" places
  shiftBy(int amount) =>
      amount > 0 ? (sublist(amount)..addAll(sublist(0, amount))) : this;
}
