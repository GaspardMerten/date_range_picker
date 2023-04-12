import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthSelectorAndDoubleIndicator extends StatelessWidget {
  const MonthSelectorAndDoubleIndicator({
    Key? key,
    required this.currentMonth,
    required this.onNext,
    required this.onPrevious,
    required this.nextMonth,
    this.style,
    this.doubleMonth = true,
  }) : super(key: key);

  final DateTime currentMonth;
  final DateTime nextMonth;
  final bool doubleMonth;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
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
              DateFormat.yMMM().format(nextMonth),
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
