import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:buco/login_screen.dart';
import 'package:buco/providers/auth_provider.dart';
import 'package:buco/providers/home_provider.dart';
import 'package:buco/providers/user_provider.dart';
import 'package:buco/providers/restaurant_provider.dart';
import 'package:buco/providers/search_provider.dart';

// Mocks
class MockAuthProvider extends Mock implements AuthProvider {}
class MockHomeProvider extends Mock implements HomeProvider {}
class MockUserProvider extends Mock implements UserProvider {}
class MockRestaurantProvider extends Mock implements RestaurantProvider {}
class MockSearchProvider extends Mock implements SearchProvider {}

void main() {
  late MockAuthProvider mockAuthProvider;
  late MockHomeProvider mockHomeProvider;
  late MockUserProvider mockUserProvider;
  late MockRestaurantProvider mockRestaurantProvider;
  late MockSearchProvider mockSearchProvider;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    mockHomeProvider = MockHomeProvider();
    mockUserProvider = MockUserProvider();
    mockRestaurantProvider = MockRestaurantProvider();
    mockSearchProvider = MockSearchProvider();
    
    // Default values
    when(() => mockAuthProvider.isLoading).thenReturn(false);
    when(() => mockAuthProvider.errorMessage).thenReturn(null);
  });

  Widget createTestWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
        ChangeNotifierProvider<HomeProvider>.value(value: mockHomeProvider),
        ChangeNotifierProvider<UserProvider>.value(value: mockUserProvider),
        ChangeNotifierProvider<RestaurantProvider>.value(value: mockRestaurantProvider),
        ChangeNotifierProvider<SearchProvider>.value(value: mockSearchProvider),
      ],
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  group('LoginScreen Tests', () {
    testWidgets('Debe renderizar los elementos principales (campos, botones y SVGs)', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Verificamos campos de texto
      expect(find.byType(TextField), findsNWidgets(2)); // Email y Password
      
      // Verificamos botones
      expect(find.text('CONTINUAR'), findsOneWidget);
      expect(find.text('Crear una cuenta'), findsOneWidget);
      expect(find.text('Iniciar con Instagram'), findsOneWidget);
      expect(find.text('Iniciar con Google'), findsOneWidget);
    });

    testWidgets('Debe mostrar CircularProgressIndicator cuando isLoading es true', (WidgetTester tester) async {
      when(() => mockAuthProvider.isLoading).thenReturn(true);
      
      await tester.pumpWidget(createTestWidget());
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('CONTINUAR'), findsNothing); // Porque es reemplazado por el loader
    });

    testWidgets('Debe llamar al login del AuthProvider al tocar CONTINUAR', (WidgetTester tester) async {
      when(() => mockAuthProvider.login(any(), any())).thenAnswer((_) async => false);
      when(() => mockAuthProvider.errorMessage).thenReturn(null);
      
      await tester.pumpWidget(createTestWidget());
      
      // Escribir en los campos
      await tester.enterText(find.byType(TextField).at(0), 'test@test.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');
      
      // Tocar el botón (como es un ElevatedButton con Text 'CONTINUAR', podemos buscar por tipo y asegurarnos)
      final loginButton = find.widgetWithText(ElevatedButton, 'CONTINUAR');
      await tester.tap(loginButton);
      
      // Pump para procesar la animación del tap y la navegación sin colgarse por animaciones
      await tester.pump(const Duration(seconds: 1));
      
      verify(() => mockAuthProvider.login('test@test.com', 'password123')).called(1);
    });

    testWidgets('Golden Test: Login Screen Pixel Perfect', (WidgetTester tester) async {
      // Ajustamos el tamaño de la pantalla física para simular el diseño
      tester.view.physicalSize = const Size(1179, 2556);
      tester.view.devicePixelRatio = 3.0;

      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(seconds: 1)); // Evitar pumpAndSettle

      await expectLater(
        find.byType(LoginScreen),
        matchesGoldenFile('goldens/login_screen.png'),
      );
      
      // Reset view properties
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });
  });
}
