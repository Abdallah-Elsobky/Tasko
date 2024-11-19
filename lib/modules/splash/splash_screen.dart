import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasko/layout/home_layout.dart';
import 'package:tasko/modules/onboarding/onboarding_screen.dart';
import 'package:tasko/shared/components/components.dart';
import 'package:tasko/shared/styles/styles.dart';
import 'package:tasko/shared/styles/theme.dart';
import 'package:themed/themed.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  bool isOld = false;

  @override
  void initState() {

    shared();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInExpo,
    );

    _controller!.forward();

    Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => (isOld) ? HomeLayout() : OnboardingScreen(),
        ),
      );
    });
    super.initState();
  }

  Future<void> shared() async {
    final sp = await SharedPreferences.getInstance();
    isOld = await sp.getBool('old_user') ?? false;
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
                  style:
                      titleText(color: Colors.black54, fontSize: 25),
                )
              ],
            ),
          ),
        ));
  }
}
