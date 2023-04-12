import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/src/models.dart';

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
