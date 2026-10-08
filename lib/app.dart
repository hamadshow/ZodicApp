import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/router/app_routes.dart';
import 'core/theme/app_theme.dart';

class ZodicApp extends StatefulWidget {
  const ZodicApp({super.key});

  @override
  State<ZodicApp> createState() => _ZodicAppState();
}

class _ZodicAppState extends State<ZodicApp> {
  final Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZodicERP',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
