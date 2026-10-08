import 'package:flutter/material.dart';

import '../../../shared/widgets/placeholder_screen.dart';

/// Company screen.
class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Company',
      description: 'Company management will be implemented next.',
      icon: Icons.business_rounded,
    );
  }
}
