import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Products screen.
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Products',
      description: 'Products management will be implemented next.',
      icon: Icons.inventory_2_rounded,
    );
  }
}
