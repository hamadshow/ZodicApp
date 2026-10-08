import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Accounting screen.
class AccountingScreen extends StatelessWidget {
  const AccountingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Accounting',
      description: 'Accounting module will be implemented next.',
      icon: Icons.calculate_rounded,
    );
  }
}
