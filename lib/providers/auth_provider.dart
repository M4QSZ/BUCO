import 'package:flutter/foundation.dart';
import '../services/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider({required AuthRepository authRepository}) : _authRepository = authRepository;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Realizar inicio de sesión
  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Por favor, rellena todos los campos.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _authRepository.signInWithEmailPassword(email, password);
      _setLoading(false);
      return true; // Éxito
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false; // Fallo
    }
  }

  // Realizar registro
  Future<bool> register(String email, String password, String confirmPassword) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _errorMessage = 'Por favor, rellena todos los campos.';
      notifyListeners();
      return false;
    }

    if (password != confirmPassword) {
      _errorMessage = 'Las contraseñas no coinciden.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      // Usar signUp real cuando esté listo, por ahora reusamos el mock signIn
      await _authRepository.signInWithEmailPassword(email, password);
      _setLoading(false);
      return true; // Éxito
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false; // Fallo
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
