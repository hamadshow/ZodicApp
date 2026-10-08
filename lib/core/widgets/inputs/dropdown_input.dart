import 'package:flutter/material.dart';

import '../../constants/app_spacing.dart';

/// Dropdown input for selecting from predefined options.
class AppDropdownInput<T> extends StatefulWidget {
  const AppDropdownInput({
    super.key,
    required this.label,
    required this.items,
    this.value,
    required this.onChanged,
    this.isRequired = false,
    this.errorText,
  });

  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T?) onChanged;
  final bool isRequired;
  final String? errorText;

  @override
  State<AppDropdownInput<T>> createState() => _AppDropdownInputState<T>();
}

class _AppDropdownInputState<T> extends State<AppDropdownInput<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.label,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  if (widget.isRequired)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Color(0xFFDC2626)),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<T>(
          initialValue: widget.value,
          items: widget.items,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            errorText: widget.errorText,
          ),
        ),
      ],
    );
  }
}
