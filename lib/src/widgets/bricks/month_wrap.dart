import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/src/models.dart';
import 'package:flutter_date_range_picker/src/utils.dart';

/// A widget that displays a wrap of a month's worth of day tiles.
class MonthWrapWidget extends StatelessWidget {
  /// Constructs a [MonthWrapWidget] widget.
  MonthWrapWidget({
    Key? key,
    required List<DayModel> days,
    required this.delta,
    required this.dayTileBuilder,
    required this.placeholderBuilder,
    this.firstDayOfWeek = 0,
  })  : days = days.shiftBy(firstDayOfWeek),
        super(key: key);

  /// The list of [DayModel]s to display.
  final List<DayModel> days;

  /// The offset of the first day to display.
  final int delta;

  /// A builder that builds a day tile given a [DayModel].
  final Widget Function(DayModel dayModel) dayTileBuilder;

  /// A builder that builds a placeholder widget given a delta index.
  final Widget Function(int deltaIndex) placeholderBuilder;

  /// 0=Sun (default), 1=Mon, ...
  final int firstDayOfWeek;

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
