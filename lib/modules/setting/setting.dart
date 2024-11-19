import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasko/layout/home_layout.dart';
import 'package:tasko/shared/components/common/sounds.dart';
import 'package:tasko/shared/styles/theme.dart';
import 'package:themed/themed.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/styles.dart';

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final ScrollController _scrollController = ScrollController();
  int? selected_theme;

  @override
  void initState() {
    shared().then((value) {
      setState(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final double position = selected_theme! * 50.0;
          _scrollController.animateTo(position,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut);
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> shared({int? index}) async {
    final sp = await SharedPreferences.getInstance();
    selected_theme = await sp.getInt('theme');
    sp.setInt('theme', index ?? selected_theme ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Theme',
              style:
                  titleText(color: Colors.black.withOpacity(.7), fontSize: 30),
            ),
            SizedBox(height: 20.h),
            // Add spacing between the title and theme selector
            Container(
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20.r)),
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: theme_colors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () async {
                        click();
                        Themed.currentTheme = themes[index];
                        shared(index: index);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => HomeLayout(num: 3)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 23.r,
                            backgroundColor:
                                theme_colors[index].withOpacity(.4),
                            child: CircleAvatar(
                              radius: (selected_theme == index) ? 20.r : 0.r,
                              backgroundColor: theme_colors[index],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          (selected_theme == index)
                              ? CircleAvatar(
                                  radius: 5,
                                  backgroundColor: theme_colors[index].withOpacity(.5),
                                )
                              : const CircleAvatar(
                                  radius: 0,
                                ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 10.w,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
