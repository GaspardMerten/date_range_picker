import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_date_range_picker/src/widgets/typedefs.dart';

/// A [StatelessWidget] that provides a field to select a date range dateRange.
class DateRangeField extends StatelessWidget {
  /// Creates a [DateRangeField].
  ///
  /// * [decoration] - The decoration to show around the field. If null, defaults to [InputDecoration].
  /// * [selectedDateRange] - The selected date range for the field.
  /// * [onDateRangeSelected] - Called when a date range is selected.
  /// * [childBuilder] - A builder to construct the child widget of the field.
  /// * [enabled] - Whether the field is enabled or not.
  /// * [pickerBuilder] - A builder to construct the date range picker widget.
  /// * [dialogFooterBuilder] - A builder to construct the footer widget of the dialog.
  /// * [showDateRangePicker] - A function to show the date range picker dialog, defaults to [showDateRangePickerDialogOnWidget].
  const DateRangeField({
    Key? key,
    this.decoration,
    this.selectedDateRange,
    this.onDateRangeSelected,
    this.childBuilder,
    this.dialogFooterBuilder,
    this.enabled = true,
    required this.pickerBuilder,
    this.showDateRangePicker = showDateRangePickerDialogOnWidget,
  }) : super(key: key);

  final Widget Function({DateRange? selectedDateRange})? dialogFooterBuilder;
  final DateRangerPickerWidgetBuilder pickerBuilder;
  final InputDecoration? decoration;
  final bool enabled;
  final DateRange? selectedDateRange;
  final ValueChanged<DateRange?>? onDateRangeSelected;
  final Widget Function(BuildContext, DateRange?)? childBuilder;
  final Future<DateRange?> Function({
    required BuildContext widgetContext,
    required DateRangerPickerWidgetBuilder pickerBuilder,
  }) showDateRangePicker;

  @override
  Widget build(BuildContext context) {
    var inputDecoration = (decoration ?? const InputDecoration()).applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );

    return InkWell(
      onTap: generateOnTap(context),
      child: InputDecorator(
        decoration: inputDecoration,
        isEmpty: selectedDateRange == null,
        child: childBuilder?.call(context, selectedDateRange) ??
            Text(
              selectedDateRange?.toString() ?? '',
            ),
      ),
    );
  }

  VoidCallback? generateOnTap(BuildContext context) {
    if (enabled) {
      return () async {
        final DateRange? dateRange = await showDateRangePicker(
          widgetContext: context,
          pickerBuilder: pickerBuilder,
        );

        onDateRangeSelected?.call(dateRange);
      };
    } else {
      return null;
    }
  }
}
