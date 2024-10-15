import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t_allam/controllers/services/auth_provider.dart';
import 'package:t_allam/views/screens/home/home_screen.dart';
import '../../views/screens/auth/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<AuthProvider>(context).user == null ? LoginScreen() : const HomeScreen();
  }
}
