import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasko/layout/home_layout.dart';
import 'package:tasko/shared/components/components.dart';
import 'package:tasko/shared/styles/styles.dart';
import 'package:tasko/shared/styles/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  final List<Widget> _pages = [
    buildPage(
        title: "Organize Your Day",
        description:
            "Plan tasks with ease! Prioritize and never miss deadlines.",
        imagePath: "assets/lottie/board1.json"),
    buildPage(
        title: "Stay on Track",
        description: "Set reminders and get notifications for your goals.",
        imagePath: "assets/lottie/board2.json"),
    buildPage(
        title: "Achieve Your Goals",
        description: "Track progress and celebrate your success.",
        imagePath: "assets/lottie/board3.json"),
    buildPage(
      title: "Boost Productivity",
      description: "Focus, work efficiently, and take refreshing breaks.",
      imagePath: "assets/lottie/board4.json",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: PageView(
                    controller: _controller,
                    children: _pages,
                    onPageChanged: (index) {
                      setState(() {
                        isLastPage = index == _pages.length - 1;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SmoothPageIndicator(
                controller: _controller,
                count: _pages.length,
                effect: WormEffect(
                  dotHeight: 15.h,
                  dotWidth: 15.w,
                  dotColor: Colors.black45,
                  activeDotColor: MyTheme.foregroundColor,
                ),
              ),
              SizedBox(height: 20.h),
              (isLastPage)
                  ? defaultButton(
                      text: "Get Started",
                      height: 55.h,
                      color: Colors.blue.shade900,
                      fun: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeLayout()));
                      })
                  : defaultButton(
                      text: "Next",
                      color: MyTheme.foregroundColor,
                      height: 55.h,
                      fun: () {
                        setState(() {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      }),
            ],
          ),
        ),
      )),
    );
  }
}

Widget buildPage({
  required String imagePath,
  required String title,
  required String description,
}) {
  return Container(
    color: MyTheme.foregroundColor.withOpacity(.9),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(imagePath, height: 400.h), // Image for the page
        Text(
          title,
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            color: Color.lerp(MyTheme.backgroundColor, Colors.white, .3),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: 300.w,
          alignment: Alignment.topLeft,
          child: Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: titleText(
                color: MyTheme.backgroundColor.withOpacity(.9),
                fontSize: 18.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
