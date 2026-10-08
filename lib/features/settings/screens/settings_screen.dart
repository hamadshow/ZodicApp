import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Settings screen.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Settings',
      description: 'Settings will be implemented next.',
      icon: Icons.settings_rounded,
    );
  }
}
