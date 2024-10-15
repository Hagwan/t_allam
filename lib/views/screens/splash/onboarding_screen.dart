import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_allam/controllers/services/auth_wrapper.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Save onboarding status in SharedPreferences
  Future<void> _setOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
  }

  // Handle when onboarding is completed
  Future<void> _onDone() async {
    await _setOnboardingSeen();  // Mark onboarding as seen
    if (!mounted) return;  // Ensure widget is still mounted
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AuthWrapper()),
    );
  }

  // Handle when onboarding is skipped
  Future<void> _onSkip() async {
    await _setOnboardingSeen();  // Mark onboarding as seen
    if (!mounted) return;  // Ensure widget is still mounted
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AuthWrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to T_Allam",
          body: "Learn Arabic in a fun and interactive way.",
          image: Center(child: Image.asset('lib/assets/images/logo.png', height: 175.0)),
        ),
        PageViewModel(
          title: "Track Your Progress",
          body: "Keep track of your learning milestones.",
          image: Center(child: Image.asset('lib/assets/images/logo.png', height: 175.0)),
        ),
        PageViewModel(
          title: "Engage with Content",
          body: "Interactive lessons and quizzes.",
          image: Center(child: Image.asset('lib/assets/images/logo.png', height: 175.0)),
        ),
      ],
      onDone: _onDone,  // Call the async done handler
      onSkip: _onSkip,  // Call the async skip handler
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Theme.of(context).primaryColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
