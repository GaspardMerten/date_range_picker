import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_date_range_picker/src/widgets/typedefs.dart';

/// A function to show the dateRange picker dialog.
///
/// * [context] - The context of the dialog.
/// * [builder] - A builder to construct the date range picker widget.
///  * [barrierColor] - The color of the barrier.
///  * [footerBuilder] - A builder to construct the footer widget of the dialog.
///  * [offset] - The offset of the dialog from the widget.
///  * [onDateRangeSelected] - Called when a date range is selected.
Future<DateRange?> showDateRangePickerDialog({
  required BuildContext context,
  required DateRangerPickerWidgetBuilder builder,
  Color barrierColor = Colors.transparent,
  Widget Function({DateRange? selectedDateRange})? footerBuilder,
  Offset? offset,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: 'DateRangePickerDialogBarrier',
    barrierColor: barrierColor,
    barrierDismissible: true,
    pageBuilder: (_, __, ___) {
      return Stack(
        children: [
          Positioned(
            top: offset?.dy ?? 0,
            left: offset?.dx ?? 0,
            child: DateRangePickerDialog(
              builder: builder,
              footerBuilder: footerBuilder ?? DateRangePickerDialogFooter.new,
            ),
          ),
        ],
      );
    },
  );
}

/// A function to show the dateRange picker dialog on a widget.
/// * [widgetContext] - The context of the widget that will be used to show the dialog.
/// * [context] - The context of the dialog. If null, the [widgetContext] will be used.
/// * [dialogFooterBuilder] - A builder to construct the footer widget of the dialog.
/// * [pickerBuilder] - A builder to construct the date range picker widget.
/// * [delta] - The offset of the dialog from the widget.
/// * [onDateRangeSelected] - Called when a date range is selected.
/// * [barrierColor] - The color of the barrier.
Future<DateRange?> showDateRangePickerDialogOnWidget({
  required BuildContext widgetContext,
  required DateRangerPickerWidgetBuilder pickerBuilder,
  BuildContext? context,
  Color barrierColor = Colors.transparent,
  Widget Function({DateRange? selectedDateRange})? dialogFooterBuilder,
  Offset delta = const Offset(0, 60),
}) {
  // Compute widget position on screen
  final RenderBox renderBox = widgetContext.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  // Show the dateRange picker dialog and get the selected date range
  final dateRange = showDateRangePickerDialog(
      context: context ?? widgetContext,
      footerBuilder: dialogFooterBuilder,
      barrierColor: barrierColor,
      builder: pickerBuilder,
      offset: offset + delta);

  return dateRange;
}

/// A dialog for selecting a date range dateRange.
class DateRangePickerDialog extends StatefulWidget {
  const DateRangePickerDialog({
    Key? key,
    required this.builder,
    required this.footerBuilder,
  }) : super(key: key);

  /// A function that builds a widget that will be used to display the date range picker.
  final DateRangerPickerWidgetBuilder builder;

  /// A function that builds a widget that will be used to display the footer.
  /// The selected dateRange will be passed to the footer builder. It can be null if
  /// no dateRange is selected yet.
  final Widget Function({DateRange? selectedDateRange}) footerBuilder;

  @override
  State<DateRangePickerDialog> createState() => _DateRangePickerDialogState();
}

class _DateRangePickerDialogState extends State<DateRangePickerDialog> {
  DateRange? dateRange;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // The date range picker widget
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: widget.builder(context, (dateRange) {
                    setState(() {
                      this.dateRange = dateRange;
                    });
                  }),
                ),
                widget.footerBuilder(selectedDateRange: dateRange),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The default footer for the dateRange picker dialog.
class DateRangePickerDialogFooter extends StatelessWidget {
  const DateRangePickerDialogFooter({
    super.key,
    this.selectedDateRange,
    this.cancelText = "Cancel",
    this.confirmText = "Confirm",
  });

  final String cancelText;
  final String confirmText;
  final DateRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(selectedDateRange);
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}
