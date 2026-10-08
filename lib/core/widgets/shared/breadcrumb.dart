import 'package:flutter/material.dart';

/// Breadcrumb navigation widget.
class AppBreadcrumb extends StatelessWidget {
  const AppBreadcrumb({
    super.key,
    required this.items,
    this.onTap,
  });

  final List<String> items;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(items.length, (index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => onTap?.call(index),
              child: Text(
                items[index],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: index == items.length - 1
                      ? Theme.of(context).textTheme.bodySmall?.color
                      : Colors.blue,
                ),
              ),
            ),
            if (index < items.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '/',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        );
      }),
    );
  }
}
