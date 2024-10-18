import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_allam/views/screens/chat/veg_model.dart';
import 'package:t_allam/views/screens/chat/veg_screen.dart';
import 'package:t_allam/views/screens/content/arabic_alphabet.dart';
import '../../../controllers/services/auth_provider.dart';
import '../auth/registration-name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            //button to navigate to the registration name screen
            ElevatedButton(
              onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ArabicAlphabetIntroScreen()));
              },
              child: const Text('Go to Registration Name Screen'),
            ),
            Text(
              'You are logged in as: ${authProvider.user?.email ?? 'Unknown'}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
