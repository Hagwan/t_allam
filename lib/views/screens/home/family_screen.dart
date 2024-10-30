import 'package:flutter/material.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عائلة', textDirection: TextDirection.rtl),
      ),
      body: const Center(
        child: Text('شاشة العائلة', textDirection: TextDirection.rtl),
      ),
    );
  }
}
