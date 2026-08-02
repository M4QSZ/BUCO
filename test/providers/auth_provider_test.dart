import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:buco/providers/auth_provider.dart';
import 'package:buco/services/repositories/auth_repository.dart';

// Mock de la clase abstracta (no de la implementación mockeada)
class MockAuthRepositoryTest extends Mock implements AuthRepository {}

void main() {
  late AuthProvider authProvider;
  late MockAuthRepositoryTest mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepositoryTest();
    authProvider = AuthProvider(authRepository: mockAuthRepository);
  });

  group('AuthProvider Tests', () {
    test('El estado inicial de loading debe ser false y errorMessage null', () {
      expect(authProvider.isLoading, isFalse);
      expect(authProvider.errorMessage, isNull);
    });

    group('login()', () {
      test('Falla cuando el email está vacío', () async {
        // Arrange
        const email = '';
        const password = 'password123';

        // Act
        final result = await authProvider.login(email, password);

        // Assert
        expect(result, isFalse);
        expect(authProvider.errorMessage, 'Por favor, rellena todos los campos.');
        expect(authProvider.isLoading, isFalse);
        verifyNever(() => mockAuthRepository.signInWithEmailPassword(any(), any()));
      });

      test('Falla cuando el password está vacío', () async {
        // Arrange
        const email = 'test@test.com';
        const password = '';

        // Act
        final result = await authProvider.login(email, password);

        // Assert
        expect(result, isFalse);
        expect(authProvider.errorMessage, 'Por favor, rellena todos los campos.');
        expect(authProvider.isLoading, isFalse);
        verifyNever(() => mockAuthRepository.signInWithEmailPassword(any(), any()));
      });

      test('Flujo de Éxito: loading cambia y hace login correctamente', () async {
        // Arrange
        const email = 'test@test.com';
        const password = 'password123';
        when(() => mockAuthRepository.signInWithEmailPassword(email, password))
            .thenAnswer((_) async => {});

        // Act
        // Ejecutamos login y no esperamos inmediatamente para probar el estado "loading" intermedio
        final futureResult = authProvider.login(email, password);
        
        // Assert (verificamos loading=true inmediatamente después de llamar a login)
        expect(authProvider.isLoading, isTrue);

        final result = await futureResult;
        
        // Assert final
        expect(result, isTrue);
        expect(authProvider.isLoading, isFalse);
        expect(authProvider.errorMessage, isNull);
        verify(() => mockAuthRepository.signInWithEmailPassword(email, password)).called(1);
      });

      test('Flujo de Error: captura excepción y setea errorMessage', () async {
        // Arrange
        const email = 'test@test.com';
        const password = 'password123';
        when(() => mockAuthRepository.signInWithEmailPassword(email, password))
            .thenThrow(Exception('Credenciales inválidas'));

        // Act
        final result = await authProvider.login(email, password);

        // Assert
        expect(result, isFalse);
        expect(authProvider.isLoading, isFalse);
        expect(authProvider.errorMessage, 'Exception: Credenciales inválidas');
        verify(() => mockAuthRepository.signInWithEmailPassword(email, password)).called(1);
      });
    });

    group('register()', () {
      test('Falla cuando algún campo está vacío', () async {
        final result = await authProvider.register('', 'pass', 'pass');
        expect(result, isFalse);
        expect(authProvider.errorMessage, 'Por favor, rellena todos los campos.');
      });

      test('Falla cuando los passwords no coinciden', () async {
        final result = await authProvider.register('test@test.com', 'pass1', 'pass2');
        expect(result, isFalse);
        expect(authProvider.errorMessage, 'Las contraseñas no coinciden.');
      });

      test('Flujo de Éxito al registrar', () async {
        // Arrange
        const email = 'test@test.com';
        const password = 'password123';
        when(() => mockAuthRepository.signInWithEmailPassword(email, password))
            .thenAnswer((_) async => {});

        // Act
        final result = await authProvider.register(email, password, password);

        // Assert
        expect(result, isTrue);
        expect(authProvider.isLoading, isFalse);
        expect(authProvider.errorMessage, isNull);
        // Hasta que haya signUp real, se está usando signIn en la lógica
        verify(() => mockAuthRepository.signInWithEmailPassword(email, password)).called(1);
      });
    });
  });
}
