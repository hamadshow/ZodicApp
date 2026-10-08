import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Reports screen.
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Reports',
      description: 'Reports module will be implemented next.',
      icon: Icons.assessment_rounded,
    );
  }
}
