import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode && defaultTargetPlatform == TargetPlatform.windows,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'BUCO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF0531C)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

