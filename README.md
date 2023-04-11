# Date Range Picker 📅

Date Range Picker is a user-friendly and simple package for Flutter that allows users to select a date range. It's designed to evolve over time, and its components are built to be reusable.

![Date Range Picker](
https://github.com/GaspardMerten/date_range_picker/main/screen.png)

## Features  ✅

- Simple and user-friendly interface
- Customizable theme
- Reusable components
- Supports minimum and maximum date limitations
- Displays two months at once for easy navigation

## Installation 🪛

Add the package to your pubspec.yaml file:

```yaml 
dependencies:
  date_range_picker: ^latest
```
Then, run flutter packages get in your terminal.

## Usage 📖

To use the Date Range Picker, simply import the package and create a DateRangePickerWidget:

```dart
import 'package:flutter_date_range_picker/date_range_picker.dart';

DateRangePickerWidget(
  onPeriodChanged: (period) {
    // Handle the selected period here
  },
);
```

## Customization 🎨

You can customize the appearance of the Date Range Picker by providing a custom CalendarTheme:

```dart
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
```

You can also specify the initial displayed date, minimum date, maximum date, and initial selected period:

```dart
DateRangePickerWidget(
  onPeriodChanged: (period) {
    // Handle the selected period here
  },
  initialDisplayedDate: DateTime.now(),
  initialPeriod: Period(start: DateTime.now(), end: DateTime.now().add(Duration(days: 7))),
  minDate: DateTime.now().subtract(Duration(days: 30)),
  maxDate: DateTime.now().add(Duration(days: 30)),
);
```


## License  📜

This package is released under the MIT License.

## Contributing  🤝 

We encourage and welcome contributions from the community to help improve and grow this project. If you would like to contribute, please feel free to fork the repository, make changes, and submit a pull request.

When contributing, please keep the following guidelines in mind:

- Always follow the best practices and coding standards for Flutter and Dart.
- Write clear, concise, and well-documented code.
- Test your changes thoroughly before submitting a pull request.
- Add or update any necessary documentation related to your changes.
- Respect the existing codebase and maintain its structure and style.

If you have any questions or need guidance, don't hesitate to reach out to the maintainer of this project. We appreciate your interest and support, and we look forward to collaborating with you!