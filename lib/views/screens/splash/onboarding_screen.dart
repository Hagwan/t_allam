import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../constants/routes.dart';

class OnboardingScreen extends StatelessWidget {
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
      onDone: () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.authWrapper);  // Navigate to AuthWrapper after onboarding
      },
      onSkip: () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.authWrapper);  // Skip onboarding
      },
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
