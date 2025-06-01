import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // <-- add Riverpod import
import 'firebase_options.dart';
import 'core/app/theme/app_theme.dart';
import 'core/app/routes/app_router.dart'; // <-- keep existing imports

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      // <-- wrap your app with ProviderScope
      child: GradswapApp(),
    ),
  );
}

class GradswapApp extends StatelessWidget {
  const GradswapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gradswap',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
