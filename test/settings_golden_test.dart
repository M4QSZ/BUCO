import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/screens/settings_menu_screen.dart';

void main() {
  testWidgets('Golden test for SettingsMenuScreen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SettingsMenuScreen(userName: 'Test User'),
      ),
    ));

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(SettingsMenuScreen),
      matchesGoldenFile('settings_golden.png'),
    );
    
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
