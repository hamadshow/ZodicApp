import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Warehouses screen.
class WarehousesScreen extends StatelessWidget {
  const WarehousesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Warehouses',
      description: 'Warehouse management will be implemented next.',
      icon: Icons.warehouse_rounded,
    );
  }
}
