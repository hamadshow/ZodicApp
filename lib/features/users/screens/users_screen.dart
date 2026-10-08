import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Users screen.
class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Users',
      description: 'User management will be implemented next.',
      icon: Icons.group_rounded,
    );
  }
}
