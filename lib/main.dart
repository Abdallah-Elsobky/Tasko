import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasko/layout/home_layout.dart';
import 'package:tasko/modules/new_tasks/new_tasks_screen.dart';
import 'package:tasko/modules/onboarding/onboarding_screen.dart';
import 'package:tasko/modules/splash/splash_screen.dart';
import 'package:tasko/shared/components/components.dart';
import 'package:tasko/shared/styles/theme.dart';
import 'package:tasko/test.dart';
import 'package:flutter/material.dart';
import 'package:themed/themed.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Themed.currentTheme = BlueTheme;
    shared_p();
  }

  Future<void> shared_p() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int theme_index = await prefs.getInt('theme') ?? 0;
    prefs.setInt('theme', theme_index);
    prefs.setBool('old_user', true);
    Themed.currentTheme = themes[theme_index];
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // showPerformanceOverlay: true,
        home: SplashScreen(),
      ),
    );
  }
}
