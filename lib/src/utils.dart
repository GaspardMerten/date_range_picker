import 'package:intl/intl.dart';

/// Returns the default week days as strings (using intl).
List<String> defaultWeekDays({int lengthOfDateNames = 3}) => DateFormat.E()
    .dateSymbols
    .WEEKDAYS
    .map((e) => e.substring(0, lengthOfDateNames))
    .toList();

extension ListUtils on List {
  /// Shifts the list by "amount" places
  shiftBy(int amount) =>
      amount > 0 ? (sublist(amount)..addAll(sublist(0, amount))) : this;
}
