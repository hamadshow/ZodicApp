import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Purchases screen - main purchases module entry point.
class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Purchases',
      description: 'Purchases module UI will be implemented next.',
      icon: Icons.shopping_bag_rounded,
    );
  }
}
