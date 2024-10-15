import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/routes.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/auth_wrapper.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/onboarding_screen.dart';  // Import the OnboardingScreen
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
        initialRoute: AppRoutes.splash,  // Set initial route
        routes: {
          AppRoutes.splash: (_) => const SplashScreen(),  // SplashScreen route
          AppRoutes.authWrapper: (_) => AuthWrapper(),
          AppRoutes.login: (_) => LoginScreen(),
          AppRoutes.signup: (_) => SignupScreen(),
          AppRoutes.home: (_) => HomeScreen(),
          AppRoutes.onboarding: (_) => OnboardingScreen(),  // Add OnboardingScreen route
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    // Simulate a 2-second splash screen delay
    await Future.delayed(const Duration(seconds: 2));

    // Get the instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the user has seen the onboarding screen
    bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (mounted) {
      if (hasSeenOnboarding) {
        // Navigate to authWrapper if onboarding was already seen
        Navigator.pushReplacementNamed(context, AppRoutes.authWrapper);
      } else {
        // Navigate to onboarding screen if not seen
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6200EA),
      body: Center(
        child: Image.asset(
          'lib/assets/images/logo.png',
          width: 400,
        ),
      ),
    );
  }
}
