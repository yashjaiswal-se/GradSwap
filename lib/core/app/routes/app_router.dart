import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/pages/signup_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/auth/presentation/pages/onboarding_page.dart';
import '../../../core/app/launch_decider.dart';

final appRouter = GoRouter(
  initialLocation: '/launch', // LaunchDecider route pe start karenge
  routes: [
    GoRoute(
      path: '/launch',
      builder: (context, state) => const LaunchDecider(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
  ],
);
