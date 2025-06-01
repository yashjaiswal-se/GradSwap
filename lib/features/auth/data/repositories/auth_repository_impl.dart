import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User> signUp(String email, String password) async {
    final fb_auth.User? user = await dataSource.signUpWithEmail(
      email,
      password,
    );
    if (user == null) {
      throw Exception('Signup failed');
    }
    return User(id: user.uid, email: user.email ?? '');
  }

  @override
  Future<User> login(String email, String password) async {
    final fb_auth.User? user = await dataSource.loginWithEmail(email, password);
    if (user == null) {
      throw Exception('Login failed');
    }
    return User(id: user.uid, email: user.email ?? '');
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }
}
