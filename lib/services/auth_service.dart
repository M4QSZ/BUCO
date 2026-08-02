import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // Cuando estés listo para conectarlo de verdad, descomenta la instancia y
  // úsala en los métodos de abajo.
  // final SupabaseClient _supabase = Supabase.instance.client;

  // Estado mock para simular que hay un usuario logueado después del login
  static bool _isLoggedIn = false;
  static String? _mockUserEmail;

  /// Iniciar sesión con Correo y Contraseña
  Future<void> signInWithEmailPassword(String email, String password) async {
    // Lógica real (comentada)
    /*
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
    */

    // Lógica simulada por ahora (esperamos 1.5s)
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Simulamos un error si la contraseña está vacía (solo como ejemplo)
    if (password.isEmpty) {
      throw Exception('La contraseña no puede estar vacía');
    }
    
    _isLoggedIn = true;
    _mockUserEmail = email;
  }

  /// Cerrar Sesión
  Future<void> signOut() async {
    // Lógica real (comentada)
    /*
    await _supabase.auth.signOut();
    */

    // Lógica simulada
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn = false;
    _mockUserEmail = null;
  }

  /// Obtener el usuario actual
  /// En la versión real devolvería un objeto User de Supabase.
  /// Por ahora, devolveremos un mapa o null si no hay sesión.
  Map<String, dynamic>? getCurrentUser() {
    // Lógica real (comentada)
    /*
    final user = _supabase.auth.currentUser;
    if (user != null) {
      return {'email': user.email};
    }
    return null;
    */

    // Lógica simulada
    if (_isLoggedIn) {
      return {
        'email': _mockUserEmail ?? 'usuario@ejemplo.com',
        'name': 'Usuario Supabase'
      };
    }
    return null;
  }
}
