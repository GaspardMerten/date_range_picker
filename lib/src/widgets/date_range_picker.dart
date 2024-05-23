import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

/// The default [CalendarTheme] used by the date range picker.
const CalendarTheme kTheme = CalendarTheme(
  selectedColor: Colors.blue,
  dayNameTextStyle: TextStyle(color: Colors.black45, fontSize: 10),
  inRangeColor: Color(0xFFD9EDFA),
  inRangeTextStyle: TextStyle(color: Colors.blue),
  selectedTextStyle: TextStyle(color: Colors.white),
  todayTextStyle: TextStyle(fontWeight: FontWeight.bold),
  defaultTextStyle: TextStyle(color: Colors.black, fontSize: 12),
  radius: 10,
  tileSize: 40,
  disabledTextStyle: TextStyle(color: Colors.grey),
);

/// A function that builds a day tile for the date range picker.
///
/// * [dayModel] - The model for the day tile to be built.
/// * [theme] - The theme to apply to the day tile.
/// * [onTap] - A callback function to be called when the day tile is tapped.
Widget kDayTileBuilder(
  DayModel dayModel,
  CalendarTheme theme,
  ValueChanged<DateTime> onTap,
) {
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

  if (!dayModel.isSelectable) {
    combinedTextStyle = combinedTextStyle.merge(theme.disabledTextStyle);
  }

  return DayTileWidget(
    size: theme.tileSize,
    textStyle: combinedTextStyle,
    backgroundColor: dayModel.isInRange ? theme.inRangeColor : null,
    color: dayModel.isSelected ? theme.selectedColor : null,
    text: dayModel.date.day.toString(),
    value: dayModel.date,
    onTap: dayModel.isSelectable ? onTap : null,
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

/// A widget that displays the names of the days of the week for the date range picker.
class DayNamesRow extends StatelessWidget {
  /// Creates a [DayNamesRow].
  ///
  /// * [key] - The [Key] for this widget.
  /// * [textStyle] - The style to apply to the day names text.
  /// * [weekDays] - The names of the days of the week to display. If null, defaults to the default week days.
  DayNamesRow({
    Key? key,
    required this.textStyle,
    List<String>? weekDays,
  })  : weekDays = weekDays ?? defaultWeekDays(),
        super(key: key);

  final TextStyle textStyle;
  final List<String> weekDays;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var day in weekDays)
          Expanded(
            child: Center(
              child: Text(
                day,
                style: textStyle,
              ),
            ),
          ),
      ],
    );
  }
}

/// A widget that displays a date range picker.
///
/// The onDateRangeChanged callback is called whenever the selected date range
/// is changed.
///
/// The initialDisplayedDate is the date that is initially displayed when the
/// picker is opened. If no initial date is provided, the current date is used.
///
/// The minimumDateRangeLength and maximumDateRangeLength properties can be used
/// to limit the length of the selected date range.
///
/// The doubleMonth property can be set to true to display two months at a time.
///
/// The disabledDates property can be used to disable specific dates.
///
/// The quickDateRanges property can be used to display a list of quick selection
/// dateRanges at the top of the picker.
///
/// The height property can be used to set the height of the picker.
///
/// The theme property can be used to customize the appearance of the picker.
class DateRangePickerWidget extends StatefulWidget {
  const DateRangePickerWidget({
    Key? key,
    required this.onDateRangeChanged,
    this.initialDisplayedDate,
    this.minimumDateRangeLength,
    this.initialDateRange,
    this.minDate,
    this.maxDate,
    this.theme = kTheme,
    this.maximumDateRangeLength,
    this.disabledDates = const [],
    this.quickDateRanges = const [],
    this.doubleMonth = true,
    this.height = 330,
    this.displayMonthsSeparator = true,
    this.separatorThickness = 1,
    this.allowSingleTapDaySelection = false,
  }) : super(key: key);

  /// Called whenever the selected date range is changed.
  final ValueChanged<DateRange?> onDateRangeChanged;

  /// A list of quick selection dateRanges displayed at the top of the picker.
  final List<QuickDateRange> quickDateRanges;

  /// The initial selected date range.
  final DateRange? initialDateRange;

  /// The maximum length of the selected date range.
  final int? maximumDateRangeLength;

  /// The minimum length of the selected date range.
  final int? minimumDateRangeLength;

  /// Set to true to display two months at a time.
  final bool doubleMonth;

  /// The earliest selectable date.
  final DateTime? minDate;

  /// The latest selectable date.
  final DateTime? maxDate;

  /// The date that is initially displayed when the picker is opened.
  final DateTime? initialDisplayedDate;

  /// The height of the picker.
  final double height;

  /// A list of dates that are disabled and cannot be selected.
  final List<DateTime> disabledDates;

  /// Set [allowSingleTapDaySelection] to true to allow single day selection
  /// with just one click (to avoid the user being required to tap on the same
  /// day twice).
  final bool allowSingleTapDaySelection;

  /// The theme used to customize the appearance of the picker.
  final CalendarTheme theme;

  /// Used to either display or hide the vertical separator between months if [doubleMonth] mode is active
  final bool displayMonthsSeparator;

  /// Thickness of the vertical separator between months if [doubleMonth] mode is active
  final double separatorThickness;

  @override
  State<DateRangePickerWidget> createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  late final controller = RangePickerController(
    dateRange: widget.initialDateRange,
    minDate: widget.minDate,
    maxDate: widget.maxDate,
    onDateRangeChanged: widget.onDateRangeChanged,
    disabledDates: widget.disabledDates,
    minimumDateRangeLength: widget.minimumDateRangeLength,
    maximumDateRangeLength: widget.maximumDateRangeLength,
    allowSingleTapDaySelection: widget.allowSingleTapDaySelection,
  );

  late final calendarController = CalendarWidgetController(
    controller: controller,
    currentMonth: widget.initialDisplayedDate ??
        widget.initialDateRange?.start ??
        DateTime.now(),
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
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.theme.tileSize * 7 * (widget.doubleMonth ? 2 : 1),
          child: MonthSelectorAndDoubleIndicator(
            doubleMonth: widget.doubleMonth,
            onPrevious: calendarController.previous,
            onNext: calendarController.next,
            currentMonth: calendarController.currentMonth,
            nextMonth: calendarController.nextMonth,
            style: widget.theme.monthTextStyle,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              EnrichedMonthWrapWidget(
                theme: widget.theme,
                onDateChanged: calendarController.onDateChanged,
                days: calendarController.retrieveDatesForMonth(),
                delta: calendarController.retrieveDeltaForMonth(),
              ),
              if (widget.doubleMonth) ...{
                if (widget.displayMonthsSeparator)
                  VerticalDivider(
                    thickness: widget.separatorThickness,
                    color: widget.theme.separatorColor,
                  ),
                EnrichedMonthWrapWidget(
                  theme: widget.theme,
                  onDateChanged: calendarController.onDateChanged,
                  days: calendarController.retrieveDatesForNextMonth(),
                  delta: calendarController.retrieveDeltaForNextMonth(),
                ),
              }
            ],
          ),
        ),
      ],
    );

    if (widget.quickDateRanges.isNotEmpty) {
      child = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: widget.theme.quickDateRangeBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.theme.radius),
              ),
            ),
            padding: const EdgeInsets.only(right: 16),
            child: QuickSelectorWidget(
              selectedDateRange: controller.dateRange,
              quickDateRanges: widget.quickDateRanges,
              onDateRangeChanged: (dateRange) {
                calendarController.setDateRange(dateRange);
              },
              theme: widget.theme,
            ),
          ),
          Container(
            color: Colors.black12,
            width: 1,
            height: double.infinity,
            margin: const EdgeInsets.only(right: 16),
          ),
          child,
          if (widget.quickDateRanges.isNotEmpty)
            const SizedBox(
              width: 16,
            ),
        ],
      );
    }

    return SizedBox(
      height: widget.height,
      child: child,
    );
  }
}

/// A widget that displays a vertical column of days in a month grid, along with the day names row.
class EnrichedMonthWrapWidget extends StatelessWidget {
  const EnrichedMonthWrapWidget({
    Key? key,
    required this.theme,
    required this.onDateChanged,
    required this.days,
    required this.delta,
  }) : super(key: key);

  /// The theme to use for the calendar.
  final CalendarTheme theme;

  /// A callback that is called when the selected date changes.
  final ValueChanged<DateTime> onDateChanged;

  /// The days to display in the month grid.
  final List<DayModel> days;

  /// The number of days to pad at the beginning of the grid.
  final int delta;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: theme.tileSize * 7,
      child: Column(
        children: [
          DayNamesRow(
            textStyle: theme.dayNameTextStyle,
          ),
          const SizedBox(height: 16),
          MonthWrapWidget(
            days: days,
            delta: delta,
            dayTileBuilder: (dayModel) => kDayTileBuilder(
              dayModel,
              theme,
              onDateChanged,
            ),
            placeholderBuilder: (index) => buildPlaceholder(),
          ),
        ],
      ),
    );
  }

  /// A placeholder widget to use for days that do not exist in the current month.
  SizedBox buildPlaceholder() => SizedBox(
        width: theme.tileSize,
        height: theme.tileSize,
      );
}
