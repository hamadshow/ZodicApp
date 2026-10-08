import 'package:flutter/material.dart';

import '../../constants/app_spacing.dart';

/// Date picker input.
class AppDateInput extends StatefulWidget {
  const AppDateInput({
    super.key,
    required this.label,
    this.hint = 'Select date',
    this.selectedDate,
    required this.onDateChanged,
    this.isRequired = false,
    this.errorText,
  });

  final String label;
  final String hint;
  final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;
  final bool isRequired;
  final String? errorText;

  @override
  State<AppDateInput> createState() => _AppDateInputState();
}

class _AppDateInputState extends State<AppDateInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.selectedDate != null ? _formatDate(widget.selectedDate!) : '',
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _controller.text = _formatDate(picked);
      widget.onDateChanged(picked);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        TextFormField(
          controller: _controller,
          readOnly: true,
          onTap: _pickDate,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: const Icon(Icons.calendar_today_outlined),
            errorText: widget.errorText,
          ),
        ),
      ],
    );
  }
}
