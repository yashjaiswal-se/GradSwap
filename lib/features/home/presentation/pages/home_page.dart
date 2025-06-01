import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gradswap Home')),
      body: const Center(
        child: Text('Welcome to Gradswap!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
