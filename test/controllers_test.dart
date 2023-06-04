import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RangePickerController tests', () {
    test('onDateChanged sets startDate', () {
      final controller = RangePickerController(
        onDateRangeChanged: (_) {},
      );
      controller.onDateChanged(DateTime(2022, 4, 1));
      expect(controller.startDate, DateTime(2022, 4, 1));
    });

    test('onDateChanged sets endDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 1),
        onDateRangeChanged: (_) {},
      );
      controller.onDateChanged(DateTime(2022, 4, 5));
      expect(controller.endDate, DateTime(2022, 4, 5));
    });

    test('onDateChanged sets startDate and clears endDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        endDate: DateTime(2022, 4, 15),
        onDateRangeChanged: (_) {},
      );
      controller.onDateChanged(DateTime(2022, 4, 5));
      expect(controller.startDate, DateTime(2022, 4, 5));
      expect(controller.endDate, null);
    });

    test('onDateChanged sets startDate and clears endDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        endDate: DateTime(2022, 4, 15),
        onDateRangeChanged: (_) {},
      );
      controller.onDateChanged(DateTime(2022, 4, 5));
      expect(controller.startDate, DateTime(2022, 4, 5));
      expect(controller.endDate, null);
    });

    test('dateInSelectedRange returns true when date is in range', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        endDate: DateTime(2022, 4, 15),
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateInSelectedRange(DateTime(2022, 4, 12)), true);
    });

    test('dateInSelectedRange returns false when startDate is null', () {
      final controller = RangePickerController(
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateInSelectedRange(DateTime(2022, 4, 12)), false);
    });

    test('dateInSelectedRange returns false when endDate is null', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateInSelectedRange(DateTime(2022, 4, 12)), false);
    });

    test(
        'dateIsSelectable returns true when date is between minDate and maxDate',
        () {
      final controller = RangePickerController(
        minDate: DateTime(2022, 4, 1),
        maxDate: DateTime(2022, 4, 30),
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateIsSelectable(DateTime(2022, 4, 15)), true);
    });

    test('dateIsSelectable returns false when date is before minDate', () {
      final controller = RangePickerController(
        minDate: DateTime(2022, 4, 15),
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateIsSelectable(DateTime(2022, 4, 1)), false);
    });

    test('dateIsSelectable returns false when date is after maxDate', () {
      final controller = RangePickerController(
        maxDate: DateTime(2022, 4, 15),
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateIsSelectable(DateTime(2022, 4, 30)), false);
    });

    test('dateIsStart returns true when date is startDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateIsStart(DateTime(2022, 4, 10)), true);
    });

    test('dateIsStart returns false when startDate is null', () {
      final controller = RangePickerController(
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateIsStart(DateTime(2022, 4, 10)), false);
    });

    test('dateIsEnd returns true when date is endDate', () {
      final controller = RangePickerController(
        endDate: DateTime(2022, 4, 15),
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateIsEnd(DateTime(2022, 4, 15)), true);
    });

    test('dateIsEnd returns false when endDate is null', () {
      final controller = RangePickerController(
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateIsEnd(DateTime(2022, 4, 15)), false);
    });

    test('dateIsStartOrEnd returns true when date is startDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateIsStartOrEnd(DateTime(2022, 4, 10)), true);
    });

    test('dateIsStartOrEnd returns true when date is endDate', () {
      final controller = RangePickerController(
        endDate: DateTime(2022, 4, 15),
        onDateRangeChanged: (_) {},
      );
      expect(controller.dateIsStartOrEnd(DateTime(2022, 4, 15)), true);
    });

    test('retrieveDatesForMonth returns the correct dates', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        endDate: DateTime(2022, 4, 15),
        onDateRangeChanged: (_) {},
      );
      final dates = controller.retrieveDatesForMonth(DateTime(2022, 4, 1));
      expect(dates.length, 30);
      expect(dates[9].isStart, true);
      expect(dates[14].isEnd, true);
      expect(dates[9].isSelected, true);
      expect(dates[11].isInRange, true);
    });

    test('retrieveDeltaForMonth returns the correct number of days to skip',
        () {
      final controller = RangePickerController(
        onDateRangeChanged: (_) {},
      );
      final delta = controller.retrieveDeltaForMonth(DateTime(2022, 4, 1));
      expect(delta, 5);
    });
  });

  test(
      'selectableDay for days + 10 in the future is false when start date is further than max dateRange (10 days) in this case. But true when before',
      () {
    final controller = RangePickerController(
      startDate: DateTime(2022, 4, 10),
      maximumDateRangeLength: 10,
      onDateRangeChanged: (_) {},
    );

    for (int i = 10; i <= 10; i++) {
      expect(controller.dateIsSelectable(DateTime(2022, 4, 10 + i)), false);
    }

    for (int i = 0; i < 10; i++) {
      expect(controller.dateIsSelectable(DateTime(2022, 4, 10 + i)), true);
    }
  });

  test(
      'dateIsSelectable returns false when start date is selected with min dateRange of 10 days if date is inside that dateRange, true otherwise.',
      () {
    final controller = RangePickerController(
      startDate: DateTime(2022, 4, 10),
      minimumDateRangeLength: 10,
      onDateRangeChanged: (_) {},
    );

    for (int i = 1; i < 9; i++) {
      expect(controller.dateIsSelectable(DateTime(2022, 4, 10 + i)), false);
    }

    for (int i = 10; i <= 10; i++) {
      expect(controller.dateIsSelectable(DateTime(2022, 4, 10 + i)), true);
    }
  });

  test('dateIsSelectable returns false when the date is specifically disabled',
      () {
    final controller = RangePickerController(
      disabledDates: [DateTime(2022, 4, 10)],
      onDateRangeChanged: (_) {},
    );

    expect(controller.dateIsSelectable(DateTime(2022, 4, 10)), false);
  });

  test('DayModel is marked as isToday when date is today', () {
    final controller = RangePickerController(
      onDateRangeChanged: (_) {},
    );

    expect(
        controller
            .retrieveDatesForMonth(DateTime.now())[DateTime.now().day - 1]
            .isToday,
        true);
  });
}
