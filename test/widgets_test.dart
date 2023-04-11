import 'package:flutter_date_range_picker/src/models.dart';
import 'package:flutter_date_range_picker/src/utils.dart';
import 'package:flutter_date_range_picker/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DayNamesRow Widget', () {
    testWidgets('renders correctly with default week days',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DayNamesRow(textStyle: kTheme.dayNameTextStyle),
        ),
      ));

      for (var day in defaultWeekDays()) {
        expect(find.text(day), findsOneWidget);
      }
    });
  });

  group('DateRangePickerWidget', () {
    testWidgets('renders correctly and initializes with initial period',
        (WidgetTester tester) async {
      final initialPeriod = Period(DateTime(2023, 1, 1), DateTime(2023, 1, 5));
      final minDate = DateTime(2022, 1, 1);
      final maxDate = DateTime(2023, 12, 31);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DateRangePickerWidget(
            initialPeriod: initialPeriod,
            minDate: minDate,
            maxDate: maxDate,
            onPeriodChanged: (Period period) {},
          ),
        ),
      ));

      expect(find.byType(DateRangePickerWidget), findsOneWidget);
      expect(find.byType(MonthSelectorAndDoubleIndicator), findsOneWidget);
      expect(find.byType(DayNamesRow), findsNWidgets(2));
      expect(find.byType(MonthWrapWidget), findsNWidgets(2));
      expect(find.byType(DayTileWidget), findsWidgets);
    });
  });
}
