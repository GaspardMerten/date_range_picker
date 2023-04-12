import 'package:flutter/material.dart';

class DayTileWidget extends StatelessWidget {
  const DayTileWidget({
    Key? key,
    required this.size,
    this.backgroundColor,
    this.color,
    this.textStyle,
    this.borderColor,
    required this.text,
    required this.value,
    required this.onTap,
    required this.radius,
    required this.backgroundRadius,
  }) : super(key: key);

  final Color? backgroundColor;
  final Color? color;
  final TextStyle? textStyle;
  final Color? borderColor;
  final String text;
  final DateTime value;
  final double size;
  final ValueChanged<DateTime>? onTap;
  final BorderRadius backgroundRadius;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: backgroundRadius,
      color: backgroundColor ?? Colors.transparent,
      child: InkWell(
        borderRadius: radius,
        onTap: () => onTap?.call(value),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor ?? Colors.transparent),
            borderRadius: radius,
          ),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
