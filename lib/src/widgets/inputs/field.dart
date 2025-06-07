import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_date_range_picker/src/widgets/typedefs.dart';
import 'package:intl/intl.dart';

/// Signature for building a string label from a selected [DateRange].
typedef DateRangeLabelBuilder = String Function(DateRange dateRange);

/// Default label builder for [DateRangeField] if no custom builder is provided.
String _defaultDateRangeLabelBuilder(DateRange dateRange,
    [DateFormat? dateFormat]) {
  dateFormat ??= DateFormat.yMMMd();
  final start = dateFormat.format(dateRange.start);
  final end = dateFormat.format(dateRange.end);
  return '$start - $end';
}

/// A widget that displays a tappable field showing a selected date range.
///
/// When tapped, it opens a custom date range picker dialog, and returns the
/// result through [onDateRangeSelected].
///
/// This widget supports extensive customization including:
/// - custom label formatting,
/// - picker widget builders,
/// - footer builders for the dialog.
///
/// ### Example
/// ```dart
/// DateRangeField(
///   selectedDateRange: _selectedDateRange,
///   pickerBuilder: ({selectedDateRange}) => MyCustomDateRangePicker(
///     initialDateRange: selectedDateRange,
///   ),
///   onDateRangeSelected: (range) {
///     setState(() {
///       _selectedDateRange = range;
///     });
///   },
/// )
/// ```
class DateRangeField extends StatelessWidget {
  const DateRangeField({
    Key? key,
    required this.pickerBuilder,
    this.decoration,
    this.selectedDateRange,
    this.onDateRangeSelected,
    this.childBuilder,
    this.dialogFooterBuilder,
    this.enabled = true,
    this.labelBuilder,
    DateFormat? dateFormat,
    this.showDateRangePicker = showDateRangePickerDialogOnWidget,
  })  : assert(
          !(labelBuilder != null && dateFormat != null),
          "You cannot provide both a labelBuilder and a dateFormat. Use one or the other.",
        ),
        super(key: key);

  /// Builds the label to display in the field from the selected [DateRange].
  ///
  /// You can provide a [DateFormat] or your own [DateRangeLabelBuilder].
  final DateRangeLabelBuilder? labelBuilder;

  /// Optional footer widget builder for the date picker dialog.
  final Widget Function({DateRange? selectedDateRange})? dialogFooterBuilder;

  /// Function that returns the actual picker widget.
  ///
  /// Required.
  final DateRangerPickerWidgetBuilder pickerBuilder;

  /// Input decoration for the field.
  final InputDecoration? decoration;

  /// Whether the field is enabled and responds to taps.
  final bool enabled;

  /// The currently selected date range, if any.
  final DateRange? selectedDateRange;

  /// Callback invoked when a new date range is selected.
  final ValueChanged<DateRange?>? onDateRangeSelected;

  /// Optionally override the child inside the field (e.g., add icons).
  final Widget Function(BuildContext, DateRange?)? childBuilder;

  /// Function to show the date picker dialog.
  ///
  /// You can override this if you use a custom dialog or modal flow.
  final Future<DateRange?> Function({
    required BuildContext widgetContext,
    required DateRangerPickerWidgetBuilder pickerBuilder,
    Widget Function({DateRange? selectedDateRange})? dialogFooterBuilder,
  }) showDateRangePicker;

  @override
  Widget build(BuildContext context) {
    final inputDecoration =
        (decoration ?? const InputDecoration()).applyDefaults(
      Theme.of(context).inputDecorationTheme,
    );

    return InkWell(
      onTap: showPicker(context),
      child: InputDecorator(
        decoration: inputDecoration,
        isEmpty: selectedDateRange == null,
        child: childBuilder?.call(context, selectedDateRange) ??
            Text(
              formatDateRange(selectedDateRange),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: enabled ? null : Theme.of(context).disabledColor,
                  ),
            ),
      ),
    );
  }

  String formatDateRange(DateRange? dateRange) {
    if (dateRange == null) return '';

    if (labelBuilder != null) {
      return labelBuilder!(dateRange);
    }
    return _defaultDateRangeLabelBuilder(dateRange, null);
  }

  /// Shows the picker dialog if [enabled] is true.
  VoidCallback? showPicker(BuildContext context) {
    if (!enabled) return null;
    return () async {
      final DateRange? dateRange = await showDateRangePicker(
        widgetContext: context,
        pickerBuilder: pickerBuilder,
        dialogFooterBuilder: dialogFooterBuilder,
      );
      onDateRangeSelected?.call(dateRange);
    };
  }
}
