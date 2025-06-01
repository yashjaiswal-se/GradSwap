import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../../data/datasources/firebase_auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/signup_user.dart';

// ---------- STATE ----------

class AuthState {
  final bool isLoading;
  final User? user;
  final String? error;

  AuthState({this.isLoading = false, this.user, this.error});

  AuthState copyWith({bool? isLoading, User? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }
}

// ---------- NOTIFIER ----------

class AuthNotifier extends StateNotifier<AuthState> {
  final SignupUser signupUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;

  AuthNotifier({
    required this.signupUser,
    required this.loginUser,
    required this.logoutUser,
  }) : super(AuthState());

  Future<void> signUp(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final user = await signupUser(email, password);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final user = await loginUser(email, password);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await logoutUser();
    state = AuthState();
  }
}

// ---------- PROVIDERS ----------

// FirebaseAuth instance provider (can be overridden in tests)
final firebaseAuthProvider = Provider<fb_auth.FirebaseAuth>((ref) {
  return fb_auth.FirebaseAuth.instance;
});

// Data source
final firebaseAuthDataSourceProvider = Provider<FirebaseAuthDataSource>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return FirebaseAuthDataSource(auth);
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(firebaseAuthDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

// Use cases
final signupUserProvider = Provider<SignupUser>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return SignupUser(repo);
});

final loginUserProvider = Provider<LoginUser>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LoginUser(repo);
});

final logoutUserProvider = Provider<LogoutUser>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LogoutUser(repo);
});

// StateNotifier
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final signup = ref.watch(signupUserProvider);
  final login = ref.watch(loginUserProvider);
  final logout = ref.watch(logoutUserProvider);

  return AuthNotifier(signupUser: signup, loginUser: login, logoutUser: logout);
});
