// signup_user.dart
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignupUser {
  final AuthRepository repository;

  SignupUser(this.repository);

  Future<User> call(String email, String password) async {
    return repository.signUp(email, password);
  }
}
