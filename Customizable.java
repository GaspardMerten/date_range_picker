Date Range Picker

Date Range Picker is a user-friendly and simple package for Flutter that allows users to select a date range. It's designed to evolve over time, and its components are built to be reusable.
Features

    Simple and user-friendly interface
    Customizable theme
    Reusable components
    Supports minimum and maximum date limitations
    Displays two months at once for easy navigation

Installation

Add the package to your pubspec.yaml file:

yaml

dependencies:
  date_range_picker: ^1.0.0

Then, run flutter packages get in your terminal.
Usage

To use the Date Range Picker, simply import the package and create a DateRangePickerWidget:

dart

import 'package:date_range_picker/date_range_picker.dart';

DateRangePickerWidget(
  onPeriodChanged: (period) {
    // Handle the selected period here
  },
);

Customization

You can customize the appearance of the Date Range Picker by providing a custom CalendarTheme:

dart

DateRangePickerWidget(
  onPeriodChanged: (period) {
    // Handle the selected period here
  },
  theme: CalendarTheme(
    selectedColor: Colors.blue,
    dayNameTextStyle: TextStyle(color: Colors.black45, fontSize: 10),
    inRangeColor: Color(0xFFD9EDFA),
    inRangeTextStyle: TextStyle(color: Colors.blue),
    selectedTextStyle: TextStyle(color: Colors.white),
    todayTextStyle: TextStyle(color: Colors.red),
    defaultTextStyle: TextStyle(color: Colors.black, fontSize: 12),
    radius: 10,
    tileSize: 40,
  ),
);

You can also specify the initial displayed date, minimum date, maximum date, and initial selected period:

dart

DateRangePickerWidget(
  onPeriodChanged: (period) {
    // Handle the selected period here
  },
  initialDisplayedDate: DateTime.now(),
  initialPeriod: Period(start: DateTime.now(), end: DateTime.now().add(Duration(days: 7))),
  minDate: DateTime.now().subtract(Duration(days: 30)),
  maxDate: DateTime.now().add(Duration(days: 30)),
);

License

This package is released under the MIT License.