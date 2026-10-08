import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Purchase returns screen.
class PurchaseReturnsScreen extends StatelessWidget {
  const PurchaseReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Purchase Returns',
      description: 'Purchase returns management will be implemented next.',
      icon: Icons.undo_rounded,
    );
  }
}
