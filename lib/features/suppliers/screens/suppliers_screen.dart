import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Suppliers screen.
class SuppliersScreen extends StatelessWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Suppliers',
      description: 'Supplier management will be implemented next.',
      icon: Icons.business_rounded,
    );
  }
}
