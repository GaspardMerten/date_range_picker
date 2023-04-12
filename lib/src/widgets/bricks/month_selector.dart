import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A widget that displays the current and next month in a row along with navigation arrows.
class MonthSelectorAndDoubleIndicator extends StatelessWidget {
  const MonthSelectorAndDoubleIndicator({
    Key? key,
    required this.currentMonth,
    required this.onNext,
    required this.onPrevious,
    this.nextMonth,
    this.style,
    this.doubleMonth = true,
  })  : assert(doubleMonth ? nextMonth != null : true),
        super(key: key);

  /// The current month displayed.
  final DateTime currentMonth;

  /// The next month displayed.
  final DateTime? nextMonth;

  /// Whether to display two months or not.
  final bool doubleMonth;

  /// A callback for when the next button is pressed.
  final VoidCallback onNext;

  /// A callback for when the previous button is pressed.
  final VoidCallback onPrevious;

  /// The text style of the displayed month.
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
        if (doubleMonth) ...[
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              DateFormat.yMMM().format(nextMonth!),
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ],
        IconButton(
          splashRadius: 16,
          onPressed: onNext,
          icon: const Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
