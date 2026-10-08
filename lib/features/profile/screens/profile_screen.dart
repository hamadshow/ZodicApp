import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Profile screen.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Profile',
      description: 'Profile management will be implemented next.',
      icon: Icons.person_rounded,
    );
  }
}
