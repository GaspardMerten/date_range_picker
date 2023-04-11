import 'package:date_range_picker/date_range_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:date_range_picker/src/models.dart';

void main() {
  group('RangePickerController tests', () {
    test('onDateChanged sets startDate', () {
      final controller = RangePickerController(
        onPeriodChanged: (_) {},
      );
      controller.onDateChanged(DateTime(2022, 4, 1));
      expect(controller.startDate, DateTime(2022, 4, 1));
    });

    test('onDateChanged sets endDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 1),
        onPeriodChanged: (_) {},
      );
      controller.onDateChanged(DateTime(2022, 4, 5));
      expect(controller.endDate, DateTime(2022, 4, 5));
    });

    test('onDateChanged sets startDate and clears endDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        endDate: DateTime(2022, 4, 15),
        onPeriodChanged: (_) {},
      );
      controller.onDateChanged(DateTime(2022, 4, 5));
      expect(controller.startDate, DateTime(2022, 4, 5));
      expect(controller.endDate, null);
    });

    test('onDateChanged sets startDate and clears endDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        endDate: DateTime(2022, 4, 15),
        onPeriodChanged: (_) {},
      );
      controller.onDateChanged(DateTime(2022, 4, 5));
      expect(controller.startDate, DateTime(2022, 4, 5));
      expect(controller.endDate, null);
    });

    test('dateInSelectedRange returns true when date is in range', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        endDate: DateTime(2022, 4, 15),
        onPeriodChanged: (_) {},
      );
      expect(controller.dateInSelectedRange(DateTime(2022, 4, 12)), true);
    });

    test('dateInSelectedRange returns false when startDate is null', () {
      final controller = RangePickerController(
        onPeriodChanged: (_) {},
      );
      expect(controller.dateInSelectedRange(DateTime(2022, 4, 12)), false);
    });

    test('dateInSelectedRange returns false when endDate is null', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        onPeriodChanged: (_) {},
      );
      expect(controller.dateInSelectedRange(DateTime(2022, 4, 12)), false);
    });

    test(
        'dateIsSelectable returns true when date is between minDate and maxDate', () {
      final controller = RangePickerController(
        minDate: DateTime(2022, 4, 1),
        maxDate: DateTime(2022, 4, 30),
        onPeriodChanged: (_) {},
      );
      expect(controller.dateIsSelectable(DateTime(2022, 4, 15)), true);
    });

    test('dateIsSelectable returns false when date is before minDate', () {
      final controller = RangePickerController(
        minDate: DateTime(2022, 4, 15),
        onPeriodChanged: (_) {},
      );
      expect(controller.dateIsSelectable(DateTime(2022, 4, 1)), false);
    });

    test('dateIsSelectable returns false when date is after maxDate', () {
      final controller = RangePickerController(
        maxDate: DateTime(2022, 4, 15),
        onPeriodChanged: (_) {},
      );
      expect(controller.dateIsSelectable(DateTime(2022, 4, 30)), false);
    });

    test('dateIsStart returns true when date is startDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        onPeriodChanged: (_) {},
      );
      expect(controller.dateIsStart(DateTime(2022, 4, 10)), true);
    });

    test('dateIsStart returns false when startDate is null', () {
      final controller = RangePickerController(
        onPeriodChanged: (_) {},
      );
      expect(controller.dateIsStart(DateTime(2022, 4, 10)), false);
    });

    test('dateIsEnd returns true when date is endDate', () {
      final controller = RangePickerController(
        endDate: DateTime(2022, 4, 15),
        onPeriodChanged: (_) {},
      );
      expect(controller.dateIsEnd(DateTime(2022, 4, 15)), true);
    });

    test('dateIsEnd returns false when endDate is null', () {
      final controller = RangePickerController(
        onPeriodChanged: (_) {},
      );
      expect(controller.dateIsEnd(DateTime(2022, 4, 15)), false);
    });

    test('dateIsStartOrEnd returns true when date is startDate', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        onPeriodChanged: (_) {},
      );
      expect(controller.dateIsStartOrEnd(DateTime(2022, 4, 10)), true);
    });

    test('dateIsStartOrEnd returns true when date is endDate', () {
      final controller = RangePickerController(
        endDate: DateTime(2022, 4, 15),
        onPeriodChanged: (_) {},
      );
      expect(controller.dateIsStartOrEnd(DateTime(2022, 4, 15)), true);
    });

    test('retrieveDatesForMonth returns the correct dates', () {
      final controller = RangePickerController(
        startDate: DateTime(2022, 4, 10),
        endDate: DateTime(2022, 4, 15),
        onPeriodChanged: (_) {},
      );
      final dates = controller.retrieveDatesForMonth(DateTime(2022, 4, 1));
      expect(dates.length, 30);
      expect(dates[9].isStart, true);
      expect(dates[14].isEnd, true);
      expect(dates[9].isSelected, true);
      expect(dates[11].isInRange, true);
    });

    test(
        'retrieveDeltaForMonth returns the correct number of days to skip', () {
      final controller = RangePickerController(
        onPeriodChanged: (_) {},
      );
      final delta = controller.retrieveDeltaForMonth(DateTime(2022, 4, 1));
      expect(delta, 4);
    });
  });
}



