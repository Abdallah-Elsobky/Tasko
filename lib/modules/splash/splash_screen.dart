import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tasko/modules/onboarding/onboarding_screen.dart';
import 'package:tasko/shared/styles/styles.dart';
import 'package:tasko/shared/styles/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInExpo,
    );

    _controller!.forward();

    Future.delayed(Duration(milliseconds: 4500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
        body: FadeTransition(
      opacity: _animation!,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/splash.json'),
            Text(
              'Tasko',
              style: titleText(color: MyTheme.foregroundColor, fontSize: 25),
            )
          ],
        ),
      ),
    ));
  }
}
