abstract class AuthRepository {
  Future<void> signInWithEmailPassword(String email, String password);
  Future<void> signOut();
  Map<String, dynamic>? getCurrentUser();
}
