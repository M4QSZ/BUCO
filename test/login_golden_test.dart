import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/login_screen.dart';

void main() {
  testWidgets('Golden test for LoginScreen', (WidgetTester tester) async {
    // Set a physical size that resembles an iPhone 12 Pro Max (what the SVG ratio is similar to)
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ));

    // Wait for SVGs to load if possible, though flutter_svg might need to be mocked for goldens or pre-cached.
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(LoginScreen),
      matchesGoldenFile('login_golden.png'),
    );
    
    // Reset sizes
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
