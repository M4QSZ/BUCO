import 'auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  bool _isLoggedIn = false;
  String? _mockUserEmail;

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    // Lógica simulada
    await Future.delayed(const Duration(milliseconds: 1500));
    
    if (password.isEmpty) {
      throw Exception('La contraseña no puede estar vacía');
    }
    
    _isLoggedIn = true;
    _mockUserEmail = email;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn = false;
    _mockUserEmail = null;
  }

  @override
  Map<String, dynamic>? getCurrentUser() {
    if (_isLoggedIn) {
      return {
        'email': _mockUserEmail ?? 'usuario@ejemplo.com',
        'name': 'Usuario Supabase'
      };
    }
    return null;
  }
}
