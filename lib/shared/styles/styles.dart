import 'dart:ffi';

import 'package:tasko/shared/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle buttonText({Color? color,double? fontSize}) => TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
    );

TextStyle taskText() => const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    );

TextStyle titleText({Color? color,double? fontSize}) => TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: color
);

TextStyle labelText() => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: MyTheme.foregroundColor,
);
