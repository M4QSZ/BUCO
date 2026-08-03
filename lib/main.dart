import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'services/repositories/mock_auth_repository.dart';
import 'providers/home_provider.dart';
import 'providers/user_provider.dart';
import 'providers/restaurant_provider.dart';
import 'providers/search_provider.dart';

import 'services/database/local_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializamos la base de datos local
  final localDb = LocalDatabase();
  await localDb.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository: MockAuthRepository())),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode && defaultTargetPlatform == TargetPlatform.windows,
        builder: (context) => const MyApp(),
      ),
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

