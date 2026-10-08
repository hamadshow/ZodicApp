import 'package:flutter/material.dart';

import '../../constants/app_spacing.dart';

/// Main application bar for authenticated pages.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    required this.onMenuPressed,
    this.title,
    this.searchHint = 'Search...',
    this.onSearch,
    this.actions,
    this.showSearch = true,
  });

  final VoidCallback onMenuPressed;
  final String? title;
  final String searchHint;
  final Function(String)? onSearch;
  final List<Widget>? actions;
  final bool showSearch;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      leading: isMobile
          ? IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: onMenuPressed,
            )
          : Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Image.asset(
                'lib/assets/logos/logo.png',
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.business_rounded, size: 32),
              ),
            ),
      title: isMobile
          ? null
          : Text(
              title ?? 'ZodicERP',
              style: Theme.of(context).textTheme.titleLarge,
            ),
      centerTitle: false,
      actions: [
        if (showSearch && !isMobile)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 260),
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    onTap: () => controller.openView(),
                    onChanged: (_) => onSearch?.call(controller.text),
                    leading: const Icon(Icons.search_rounded),
                    hintText: searchHint,
                    constraints: const BoxConstraints(
                      minHeight: 40,
                    ),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return [];
                },
              ),
            ),
          ),
        ...(actions ?? []),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
