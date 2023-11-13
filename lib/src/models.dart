import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A model that represents a date range.
/// It is used to represent the selected date range in the calendar.
/// * [start] - The start date of the date range.
/// * [end] - The end date of the date range.
/// * [duration] - The duration of the date range in days.
class DateRange {
  final DateTime start;
  final DateTime end;

  DateRange(this.start, this.end);

  @override
  String toString() {
    return "${DateFormat('dd/MM/yyyy').format(start)} - ${DateFormat('dd/MM/yyyy').format(end)}";
  }

  /// Returns the duration of the date range in days.
  int get duration => end.difference(start).inDays;

  /// Returns whether the date range contains the given [date] or not.
  bool contains(DateTime date) {
    return (date.isAtSameMomentAs(start) || date.isAfter(start)) &&
        (date.isAtSameMomentAs(end) || date.isBefore(end));
  }

  @override
  bool operator ==(Object other) {
    // Check whether the other object is a QuickDateRange
    // and whether both start and end dates are on the same day (comparison
    // is done attribute by attribute).
    if (other is DateRange) {
      return start.year == other.start.year &&
          start.month == other.start.month &&
          start.day == other.start.day &&
          end.year == other.end.year &&
          end.month == other.end.month &&
          end.day == other.end.day;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}

/// A model that represents a day in the calendar. It possesses all the information
/// needed to display the corresponding day tile in the calendar.
class DayModel {
  /// The date of the day.
  final DateTime date;

  /// Whether the day is selected or not.
  final bool isSelected;

  /// Whether the day is selectable or not.
  final bool isSelectable;

  /// Whether the day is today or not.
  final bool isToday;

  /// Whether the day is the start of the selected range or not.
  final bool isStart;

  /// Whether the day is the end of the selected range or not.
  final bool isEnd;

  /// Whether the day is in the selected range or not.
  final bool isInRange;

  DayModel({
    required this.date,
    required this.isSelected,
    required this.isSelectable,
    required this.isToday,
    required this.isStart,
    required this.isEnd,
    required this.isInRange,
  });
}

/// A customizable theme for the calendar widget.
class CalendarTheme {
  /// The color of the selected day.
  final Color selectedColor;

  /// The color of the days in the selected range.
  final Color inRangeColor;

  /// The text style of the days in the selected range.
  final TextStyle inRangeTextStyle;

  /// The text style of the selected day.
  final TextStyle selectedTextStyle;

  /// The text style of the selected day.
  final TextStyle disabledTextStyle;

  /// The text style of the today day.
  final TextStyle todayTextStyle;

  /// The default text style of the days.
  final TextStyle defaultTextStyle;

  /// The radius of the day tiles.
  final double radius;

  /// The size of the day tiles.
  final double tileSize;

  /// The text style for the months.
  final TextStyle? monthTextStyle;

  /// The text style for the day names.
  final TextStyle dayNameTextStyle;

  /// The text style for the quick selection dateRange labels.
  final TextStyle quickDateRangeTextStyle;

  /// The color of the selected quick selection dateRange (left border).
  final Color? selectedQuickDateRangeColor;

  /// The color of the vertical separator between months
  final Color? separatorColor;

  const CalendarTheme(
      {required this.selectedColor,
      required this.inRangeColor,
      required this.inRangeTextStyle,
      required this.selectedTextStyle,
      required this.todayTextStyle,
      required this.defaultTextStyle,
      required this.disabledTextStyle,
      this.quickDateRangeTextStyle = const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      this.monthTextStyle,
      this.dayNameTextStyle =
          const TextStyle(color: Colors.black45, fontSize: 10),
      required this.radius,
      required this.tileSize,
      this.selectedQuickDateRangeColor,
      this.separatorColor});
}

/// A model that represents a quick selection dateRange in the quick selection widget.
/// The date range is required but can be null. If null, the quick selection
/// will reset the selected date range.
class QuickDateRange {
  final DateRange? dateRange;
  final String label;

  QuickDateRange({required this.dateRange, required this.label});
}
