import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_date_range_picker/src/widgets/typedefs.dart';
import 'package:intl/intl.dart';

/// A [FormField] that integrates a tappable date range field with form
/// validation, saving, and change tracking support.
///
/// Useful in form-based UIs like user profile editors, booking flows, etc.
///
/// This wraps [DateRangeField] and allows validation and state management
/// within a `Form` widget.
///
/// ### Example
/// ```dart
/// final _formKey = GlobalKey<FormState>();
///
/// Form(
///   key: _formKey,
///   child: Column(
///     children: [
///       DateRangeFormField(
///         pickerBuilder: ({selectedDateRange}) => MyCustomDateRangePicker(
///           initialDateRange: selectedDateRange,
///         ),
///         validator: (range) {
///           if (range == null) return 'Please select a range';
///           if (range.duration.inDays < 1) return 'Range must be at least one day';
///           return null;
///         },
///         onSaved: (range) {
///           print('Saved: $range');
///         },
///       ),
///       ElevatedButton(
///         onPressed: () {
///           if (_formKey.currentState!.validate()) {
///             _formKey.currentState!.save();
///           }
///         },
///         child: Text('Submit'),
///       ),
///     ],
///   ),
/// )
/// ```
class DateRangeFormField extends FormField<DateRange> {
  DateRangeFormField({
    Key? key,

    /// Optional decoration for the input field.
    InputDecoration? decoration,

    /// Whether the field is interactive.
    bool enabled = true,

    /// The initial value of the date range.
    DateRange? initialValue,

    /// Required builder for the custom date range picker widget.
    required DateRangerPickerWidgetBuilder pickerBuilder,

    /// Called when the form is saved via `FormState.save()`.
    FormFieldSetter<DateRange>? onSaved,

    /// Called to validate the selected date range.
    FormFieldValidator<DateRange>? validator,

    /// Override for the picker dialog mechanism.
    Future<DateRange?> Function({
      required BuildContext widgetContext,
      required DateRangerPickerWidgetBuilder pickerBuilder,
      Widget Function({DateRange? selectedDateRange})? dialogFooterBuilder,
    }) showDateRangePicker = showDateRangePickerDialogOnWidget,

    /// Builder for optional footer in the date picker dialog.
    Widget Function({DateRange? selectedDateRange})? dialogFooterBuilder,

    /// Custom builder for the field’s child widget.
    Widget Function(BuildContext, DateRange?)? builder,

    /// Custom label formatter for the selected date range.
    DateRangeLabelBuilder? labelBuilder,

    /// An alternative to [labelBuilder] for quick formatting.
    DateFormat? dateFormat,
  }) : super(
          key: key,
          initialValue:
              initialValue ?? DateRange(DateTime.now(), DateTime.now()),
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<DateRange> state) {
            final selectedDateRange = state.value;
            final inputDecoration =
                (decoration ?? const InputDecoration()).applyDefaults(
              Theme.of(state.context).inputDecorationTheme,
            );

            return DateRangeField(
              showDateRangePicker: showDateRangePicker,
              dialogFooterBuilder: dialogFooterBuilder,
              decoration: inputDecoration.copyWith(errorText: state.errorText),
              enabled: enabled,
              selectedDateRange: selectedDateRange,
              onDateRangeSelected: enabled
                  ? (dateRange) {
                      state.didChange(dateRange);
                    }
                  : null,
              childBuilder: builder,
              pickerBuilder: pickerBuilder,
              labelBuilder: labelBuilder,
              dateFormat: dateFormat,
            );
          },
        );
}
