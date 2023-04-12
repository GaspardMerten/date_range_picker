import 'package:flutter/material.dart';

/// A widget that represents a day tile for a calendar.
///
/// A day tile can be used to display a day of the month, and allows users to select a specific day in a calendar. This widget
/// is typically used within a larger calendar widget to represent individual days.
class DayTileWidget extends StatelessWidget {
  /// Creates a day tile widget.
  ///
  /// [size] is the size of the day tile.
  /// [text] is the text that will be displayed on the day tile.
  /// [value] is the date that the day tile represents.
  /// [radius] is the radius of the day tile.
  /// [backgroundRadius] is the radius of the day tile's background.
  /// [backgroundColor] is the background color of the day tile.
  /// [color] is the color of the day tile.
  /// [textStyle] is the style of the text on the day tile.
  /// [borderColor] is the color of the day tile's border.
  /// [onTap] is the function that will be called when the day tile is tapped.
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

  /// The background color of the day tile.
  final Color? backgroundColor;

  /// The color of the day tile.
  final Color? color;

  /// The style of the text on the day tile.
  final TextStyle? textStyle;

  /// The color of the day tile's border.
  final Color? borderColor;

  /// The text that will be displayed on the day tile.
  final String text;

  /// The date that the day tile represents.
  final DateTime value;

  /// The size of the day tile.
  final double size;

  /// The function that will be called when the day tile is tapped.
  final ValueChanged<DateTime>? onTap;

  /// The radius of the day tile.
  final BorderRadius radius;

  /// The radius of the day tile's background.
  final BorderRadius backgroundRadius;

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
