import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

/// A widget that displays a list of quick dateRanges that can be selected.
class QuickSelectorWidget extends StatelessWidget {
  const QuickSelectorWidget({
    Key? key,
    required this.selectedDateRange,
    required this.quickDateRanges,
    required this.onDateRangeChanged,
    required this.theme,
  }) : super(key: key);

  /// The dateRange that is currently selected. A line will be displayed on the left
  /// using the [CalendarTheme.selectedQuickDateRangeColor] color.
  final DateRange? selectedDateRange;

  /// The list of quick dateRanges to display.
  final List<QuickDateRange> quickDateRanges;

  /// Called when a quick dateRange is selected.
  final ValueChanged<DateRange> onDateRangeChanged;

  /// The theme of the calendar.
  final CalendarTheme theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView(
        children: [
          for (final quickDateRange in quickDateRanges)
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(2)),
                    color: quickDateRange.dateRange == selectedDateRange
                        ? theme.selectedQuickDateRangeColor ??
                            Theme.of(context).primaryColor
                        : Colors.transparent,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => onDateRangeChanged(quickDateRange.dateRange),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          quickDateRange.label,
                          textAlign: TextAlign.left,
                          style: theme.quickDateRangeTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
