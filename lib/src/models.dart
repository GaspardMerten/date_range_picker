import 'package:flutter/material.dart';

class Period {
  final DateTime start;
  final DateTime end;

  Period(this.start, this.end);

  @override
  String toString() {
    return "Period: $start to $end";
  }
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

  const CalendarTheme({
    required this.selectedColor,
    required this.inRangeColor,
    required this.inRangeTextStyle,
    required this.selectedTextStyle,
    required this.todayTextStyle,
    required this.defaultTextStyle,
    required this.disabledTextStyle,
    this.monthTextStyle,
    this.dayNameTextStyle =
        const TextStyle(color: Colors.black45, fontSize: 10),
    required this.radius,
    required this.tileSize,
  });
}
