import 'package:flutter/material.dart';

/// Date text widget for displaying formatted dates.
class AppDateText extends StatelessWidget {
  const AppDateText({
    super.key,
    required this.date,
    this.format = 'MMM dd, yyyy',
    this.textStyle,
  });

  final DateTime date;
  final String format;
  final TextStyle? textStyle;

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDate(date),
      style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
    );
  }
}
