import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signUp(String email, String password);
  Future<User> login(String email, String password);
  Future<void> logout();
}
