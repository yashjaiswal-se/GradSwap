import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/storage_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LaunchDecider extends StatefulWidget {
  const LaunchDecider({super.key});

  @override
  State<LaunchDecider> createState() => _LaunchDeciderState();
}

class _LaunchDeciderState extends State<LaunchDecider> {
  @override
  void initState() {
    super.initState();
    _decideNext();
  }

  Future<void> _decideNext() async {
    final isFirstTime = await StorageHelper.isFirstLaunch();
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    if (!mounted) return;

    if (isFirstTime) {
      context.go('/onboarding');
    } else if (!isLoggedIn) {
      context.go('/login');
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
