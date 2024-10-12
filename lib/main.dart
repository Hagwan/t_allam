import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/routes.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/auth_wrapper.dart';
import 'screens/auth/login_screen.dart';    
import 'screens/auth/signup_screen.dart';   
import 'screens/home/home_screen.dart';     
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'T_Allam',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          
        ),
        initialRoute: AppRoutes.authWrapper,
        routes: {
          AppRoutes.authWrapper: (_) => AuthWrapper(),
          AppRoutes.login: (_) => LoginScreen(),
          AppRoutes.signup: (_) => SignupScreen(),
          AppRoutes.home: (_) => HomeScreen(),
        },
      ),
    );
  }
}