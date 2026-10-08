import 'package:flutter/material.dart';

import '../../constants/app_spacing.dart';

/// Company selector dropdown.
class AppCompanySelector extends StatelessWidget {
  const AppCompanySelector({
    super.key,
    required this.companies,
    required this.selectedCompany,
    required this.onCompanyChanged,
  });

  final List<Map<String, dynamic>> companies;
  final Map<String, dynamic> selectedCompany;
  final Function(Map<String, dynamic>) onCompanyChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      position: PopupMenuPosition.under,
      itemBuilder: (BuildContext context) => companies
          .map((company) => PopupMenuItem<String>(
                value: company['id'],
                onTap: () => onCompanyChanged(company),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          (company['code'] as String? ?? 'ZRP').substring(0, 1),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            company['name'] ?? 'Company',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            company['code'] ?? 'N/A',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    if (company['id'] == selectedCompany['id'])
                      Icon(Icons.check_rounded,
                          color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ))
          .toList(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  (selectedCompany['code'] as String? ?? 'ZRP')
                      .substring(0, 1),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedCompany['name'] ?? 'Company',
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    selectedCompany['code'] ?? 'N/A',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.expand_more_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
