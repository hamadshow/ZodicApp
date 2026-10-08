import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Sales returns screen.
class SalesReturnsScreen extends StatelessWidget {
  const SalesReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Sales Returns',
      description: 'Sales returns management will be implemented next.',
      icon: Icons.undo_rounded,
    );
  }
}
