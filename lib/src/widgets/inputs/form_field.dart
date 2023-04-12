import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_date_range_picker/src/widgets/typedefs.dart';

/// A [FormField] that wraps a [DateRangeField] and integrates with a form.
class DateRangeFormField extends FormField<DateRange> {
  /// Creates a [DateRangeFormField].
  ///
  /// * [decoration] - The decoration to show around the field. If null, defaults to [InputDecoration].
  /// * [enabled] - Whether the field is enabled or not.
  /// * [initialValue] - The initial [DateRange] for the field.
  /// * [pickerBuilder] - A builder to construct the date range picker widget.
  /// * [onSaved] - Called when the form is saved.
  /// * [validator] - Called to validate the field value when the form is submitted.
  /// * [builder] - A builder to construct the child widget of the field.
  /// * [dialogFooterBuilder] - A builder to construct the footer widget of the dialog.
  /// * [showDateRangePicker] - A function to show the date range picker dialog, defaults to [showDateRangePickerDialogOnWidget].
  DateRangeFormField({
    Key? key,
    InputDecoration? decoration,
    bool enabled = true,
    DateRange? initialValue,
    required DateRangerPickerWidgetBuilder pickerBuilder,
    FormFieldSetter<DateRange>? onSaved,
    FormFieldValidator<DateRange>? validator,
    Future<DateRange?> Function({
      required BuildContext widgetContext,
      required DateRangerPickerWidgetBuilder pickerBuilder,
    })
        showDateRangePicker = showDateRangePickerDialogOnWidget,
    Widget Function({DateRange? selectedDateRange})? dialogFooterBuilder,
    Widget Function(BuildContext, DateRange?)? builder,
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
            );
          },
        );
}
