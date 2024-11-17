import 'package:tasko/layout/home_layout.dart';
import 'package:tasko/modules/new_tasks/new_tasks_screen.dart';
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
    Themed.currentTheme = BlueTheme;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner:false,
        // showPerformanceOverlay: true,
        home : HomeLayout(),
      ),
    );
  }
}
