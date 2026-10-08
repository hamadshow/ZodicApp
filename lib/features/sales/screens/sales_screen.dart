import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Sales screen - main sales module entry point.
class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Sales',
      description: 'Sales module UI will be implemented next.',
      icon: Icons.shopping_cart_rounded,
    );
  }
}
