import 'dart:async';

import 'package:flutter_date_range_picker/src/controllers.dart';
import 'package:flutter_date_range_picker/src/models.dart';
import 'package:flutter_date_range_picker/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const CalendarTheme kTheme = CalendarTheme(
  selectedColor: Colors.blue,
  dayNameTextStyle: TextStyle(color: Colors.black45, fontSize: 10),
  inRangeColor: Color(0xFFD9EDFA),
  inRangeTextStyle: TextStyle(color: Colors.blue),
  selectedTextStyle: TextStyle(color: Colors.white),
  todayTextStyle: TextStyle(color: Colors.red),
  defaultTextStyle: TextStyle(color: Colors.black, fontSize: 12),
  radius: 10,
  tileSize: 40,
);

/// The default day tile builder.
Widget kDayTileBuilder(
    DayModel dayModel, CalendarTheme theme, ValueChanged<DateTime> onTap) {
  TextStyle combinedTextStyle = theme.defaultTextStyle;

  if (dayModel.isToday) {
    combinedTextStyle = combinedTextStyle.merge(theme.todayTextStyle);
  }

  if (dayModel.isInRange) {
    combinedTextStyle = combinedTextStyle.merge(theme.inRangeTextStyle);
  }

  if (dayModel.isSelected) {
    combinedTextStyle = combinedTextStyle.merge(theme.selectedTextStyle);
  }

  return DayTileWidget(
    size: theme.tileSize,
    textStyle: combinedTextStyle,
    backgroundColor: dayModel.isInRange ? theme.inRangeColor : null,
    color: dayModel.isSelected ? theme.selectedColor : null,
    text: dayModel.date.day.toString(),
    value: dayModel.date,
    onTap: onTap,
    radius: BorderRadius.horizontal(
      left: Radius.circular(
          dayModel.isEnd && dayModel.isInRange ? 0 : theme.radius),
      right: Radius.circular(
          dayModel.isStart && dayModel.isInRange ? 0 : theme.radius),
    ),
    backgroundRadius: BorderRadius.horizontal(
      left: Radius.circular(dayModel.isStart ? theme.radius : 0),
      right: Radius.circular(dayModel.isEnd ? theme.radius : 0),
    ),
  );
}

class DayNamesRow extends StatelessWidget {
  DayNamesRow({
    super.key,
    required this.textStyle,
    List<String>? weekDays,
  }) : weekDays = weekDays ?? defaultWeekDays();

  final TextStyle textStyle;
  final List<String> weekDays;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (var day in weekDays)
        Expanded(
          child: Center(
            child: Text(
              day,
              style: textStyle,
            ),
          ),
        ),
    ]);
  }
}

class DateRangePickerWidget extends StatefulWidget {
  const DateRangePickerWidget({
    Key? key,
    required this.onPeriodChanged,
    this.initialDisplayedDate,
     this.initialPeriod,  this.minDate,  this.maxDate,
    this.theme = kTheme,
  }) : super(key: key);

  final ValueChanged<Period> onPeriodChanged;
  final Period? initialPeriod;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? initialDisplayedDate;
  final CalendarTheme theme;

  @override
  State<DateRangePickerWidget> createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  late final controller = RangePickerController(
    period: widget.initialPeriod,
    minDate: widget.minDate,
    maxDate: widget.maxDate,
    onPeriodChanged: widget.onPeriodChanged,
  );

  late final calendarController = CalendarWidgetController(
    controller: controller,
    currentMonth: widget.initialDisplayedDate ?? widget.initialPeriod?.start ?? DateTime.now(),
  );

  late final StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    subscription = calendarController.updateStream.listen((event) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.theme.tileSize * 7 * 2,
          child: MonthSelectorAndDoubleIndicator(
            onPrevious: calendarController.previous,
            onNext: calendarController.next,
            currentMonth: calendarController.currentMonth,
            nextMonth: calendarController.nextMonth,
            style: widget.theme.monthTextStyle,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: widget.theme.tileSize * 7,
              child: Column(
                children: [
                  DayNamesRow(
                    textStyle: widget.theme.dayNameTextStyle,
                  ),
                  const SizedBox(height: 16),
                  MonthWrapWidget(
                    days: calendarController.retrieveDatesForMonth(),
                    delta: calendarController.retrieveDeltaForMonth(),
                    dayTileBuilder: (dayModel) => kDayTileBuilder(
                      dayModel,
                      widget.theme,
                      calendarController.onDateChanged,
                    ),
                    placeholderBuilder: (index) => buildPlaceholder(),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: widget.theme.tileSize * 7,
              child: Column(
                children: [
                  DayNamesRow(
                    textStyle: widget.theme.dayNameTextStyle,
                  ),
                  const SizedBox(height: 16),
                  MonthWrapWidget(
                    days: calendarController.retrieveDatesForNextMonth(),
                    delta: calendarController.retrieveDeltaForNextMonth(),
                    dayTileBuilder: (dayModel) => kDayTileBuilder(
                      dayModel,
                      widget.theme,
                      calendarController.onDateChanged,
                    ),
                    placeholderBuilder: (index) => buildPlaceholder(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox buildPlaceholder() => SizedBox(
        width: widget.theme.tileSize,
        height: widget.theme.tileSize,
      );
}

class MonthSelectorAndDoubleIndicator extends StatelessWidget {
  const MonthSelectorAndDoubleIndicator({
    Key? key,
    required this.currentMonth,
    required this.onNext,
    required this.onPrevious,
    required this.nextMonth,
    this.style,
  }) : super(key: key);

  final DateTime currentMonth;
  final DateTime nextMonth;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPrevious,
          splashRadius: 16,
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        Expanded(
          child: Text(
            DateFormat.yMMM().format(currentMonth),
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            DateFormat.yMMM().format(nextMonth),
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        IconButton(
          splashRadius: 16,
          onPressed: onNext,
          icon: const Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}

class MonthWrapWidget extends StatelessWidget {
  const MonthWrapWidget({
    Key? key,
    required this.days,
    required this.delta,
    required this.dayTileBuilder,
    required this.placeholderBuilder,
  }) : super(key: key);

  final int delta;
  final Widget Function(DayModel dayModel) dayTileBuilder;
  final Widget Function(int deltaIndex) placeholderBuilder;
  final List<DayModel> days;

  @override
  Widget build(BuildContext context) {
    int column = 7;
    int row = (days.length / column).ceil() + 1;

    return Column(
      children: List.generate(row, (rowIndex) {
        return Row(
          children: List.generate(column, (columnIndex) {
            if (rowIndex * column + columnIndex < delta) {
              return placeholderBuilder(columnIndex);
            }
            if (rowIndex * column + columnIndex - delta >= days.length) {
              return placeholderBuilder(columnIndex);
            }

            var dayModel = days[rowIndex * column + columnIndex - delta];

            return dayTileBuilder(dayModel);
          }),
        );
      }),
    );
  }
}

class DayTileWidget extends StatelessWidget {
  const DayTileWidget({
    Key? key,
    required this.size,
    this.backgroundColor,
    this.color,
    this.textStyle,
    this.borderColor,
    required this.text,
    required this.value,
    required this.onTap,
    required this.radius,
    required this.backgroundRadius,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? color;
  final TextStyle? textStyle;
  final Color? borderColor;
  final String text;
  final DateTime value;
  final double size;
  final ValueChanged<DateTime> onTap;
  final BorderRadius backgroundRadius;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: backgroundRadius,
      color: backgroundColor ?? Colors.transparent,
      child: InkWell(
        borderRadius: radius,
        onTap: () => onTap(value),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor ?? Colors.transparent),
            borderRadius: radius,
          ),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
