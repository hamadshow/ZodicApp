import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Inventory screen.
class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Inventory',
      description: 'Inventory management will be implemented next.',
      icon: Icons.layers_rounded,
    );
  }
}
