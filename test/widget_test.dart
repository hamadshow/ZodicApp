import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zodicapp/app.dart';
import 'package:zodicapp/app_shell/app_shell.dart';
import 'package:zodicapp/core/router/app_router.dart';
import 'package:zodicapp/core/router/app_routes.dart';
import 'package:zodicapp/core/widgets/loading/loading_indicator.dart';
import 'package:zodicapp/features/dashboard/screens/dashboard_screen.dart';

void main() {
  testWidgets('app launches to login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ZodicApp());

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Forgot?'), findsOneWidget);
  });

  testWidgets('loading page can render inside scrollable container', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: AppLoadingPage(message: 'Loading dashboard...'),
          ),
        ),
      ),
    );

    expect(find.text('Loading dashboard...'), findsOneWidget);
  });

  testWidgets('mobile app shell menu opens the drawer', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        home: AppShell(
          currentRoute: AppRoutes.dashboard,
          child: const SizedBox.shrink(),
          onNavigate: (_) {},
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.menu_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(Drawer), findsOneWidget);
  });

  testWidgets('dashboard renders key overview content', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard Overview'), findsOneWidget);
    expect(find.text('This Month'), findsOneWidget);
    expect(find.text('Revenue'), findsOneWidget);
  });

  testWidgets('successful login navigates to dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'MyPassword123');
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard Overview'), findsOneWidget);
  });
}
