import 'dart:ffi';

import 'package:tasko/shared/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/task.dart';
import '../styles/styles.dart';
import 'enums.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  double fontSize = 20,
  required String text,
  required Function fun,
}) =>
    Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: MaterialButton(
        onPressed: () {
          fun();
        },
        child: Text(
          text,
          style: buttonText(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  // required String hint,
  required IconData prefix,
  required Function validator,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    Container(
      decoration: BoxDecoration(
        color: MyTheme.backgroundColor.color.withOpacity(.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        clipBehavior: Clip.antiAlias,
        controller: controller,
        keyboardType: type,
        style: taskText(),
        cursorColor: MyTheme.foregroundColor,
        obscureText: isPassword,
        onFieldSubmitted: (s) {
          if (onSubmit != null) {
            onSubmit(s);
          }
        },
        onChanged: (s) {
          if (onChange != null) {
            onChange(s);
          }
        },
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        enabled: isClickable,
        validator: (s) {
          return validator(s);
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: labelText(),
          prefixIcon: Icon(
            prefix,
            color: MyTheme.foregroundColor,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(
                    suffix,
                    color: Colors.white,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 1.w, color: MyTheme.foregroundColor),
          ),
        ),
      ),
    );

List<Color> task_colors = [
  MyTheme.task1Color,
  MyTheme.task2Color,
  MyTheme.task3Color,
  MyTheme.task4Color,
  MyTheme.task5Color,
  MyTheme.task6Color,
  MyTheme.task7Color,
  MyTheme.task8Color,
  MyTheme.task15Color,
  MyTheme.task10Color,
  MyTheme.task11Color,
  MyTheme.task9Color,
  MyTheme.task12Color,
  MyTheme.task13Color,
  MyTheme.task14Color,
];
List<Color> type_colors = [
  MyTheme.type1Color,
  MyTheme.type2Color,
  MyTheme.type3Color,
  MyTheme.type4Color,
];
List<String> images = [
  'assets/shape/shape1.png',
  'assets/shape/shape2.png',
  'assets/shape/shape3.png',
  'assets/shape/shape4.png',
  'assets/shape/shape5.png',
  'assets/shape/shape6.png',
  'assets/shape/shape7.png',
  'assets/shape/shape8.png',
  'assets/shape/shape9.png',
  'assets/shape/shape10.png',
  'assets/shape/shape12.png',
  'assets/shape/shape13.png',
  'assets/shape/shape14.png',
  'assets/shape/shape15.png',
  'assets/shape/shape16.png',
  'assets/shape/shape17.png',
  'assets/shape/shape18.png',
  'assets/shape/shape19.png',
];

List<String> flork = [
  'assets/flork/flork2.png',
  'assets/flork/flork3.png',
  'assets/flork/flork4.png',
  'assets/flork/flork5.png',
  'assets/flork/flork7.png',
  'assets/flork/flork8.png',
  'assets/flork/flork9.png',
  'assets/flork/flork10.png',
  'assets/flork/flork11.png',
  'assets/flork/flork12.png',
  'assets/flork/flork13.png',
  'assets/flork/flork14.png',
  'assets/flork/flork15.png',
  'assets/flork/flork6.png',
  'assets/flork/flork16.png',
];

List<Task> done_tasks = [];
List<Task> archive_tasks = [];
List<String> task_types = [
  getTypeName(0),
  getTypeName(1),
  getTypeName(2),
  getTypeName(3),
];
Map<int, Task> priority1_tasks = {};
Map<int, Task> priority2_tasks = {};
Map<int, Task> priority3_tasks = {};
Map<int, Task> priority4_tasks = {};

Map<int, Task> getTasksByPriority(int index) {
  switch (index) {
    case 0:
      return priority1_tasks;
    case 1:
      return priority2_tasks;
    case 2:
      return priority3_tasks;
    default:
      return priority4_tasks;
  }
}

void clearTasks() {
  priority1_tasks.clear();
  priority2_tasks.clear();
  priority3_tasks.clear();
  priority4_tasks.clear();
  done_tasks.clear();
  archive_tasks.clear();
}

String getName(String title) {
  if (title == type.URGENT_IMPORTANT.name) {
    return "Urgent and Important";
  } else if (title == type.NOT_URGENT_IMPORTANT.name) {
    return "Not Urgent and Important";
  } else if (title == type.URGENT_NOT_IMPORTANT.name) {
    return "Urgent and Not Important";
  } else {
    return "Not Urgent and Not Important";
  }
}

int getType(String item) {
  if (item == type.URGENT_IMPORTANT.name) {
    return 0;
  } else if (item == type.NOT_URGENT_IMPORTANT.name) {
    return 1;
  } else if (item == type.URGENT_NOT_IMPORTANT.name) {
    return 2;
  } else {
    return 3;
  }
}

String getTypeName(int item) {
  if (item == 0) {
    return getName(type.URGENT_IMPORTANT.name);
  } else if (item == 1) {
    return getName(type.NOT_URGENT_IMPORTANT.name);
  } else if (item == 2) {
    return getName(type.URGENT_NOT_IMPORTANT.name);
  } else {
    return getName(type.NOT_URGENT_NOT_IMPORTANT.name);
  }
}

Color getTaskColor(int index) {
  return task_colors[index % task_colors.length];
}

Color getTypeColor(int index) {
  return type_colors[index % type_colors.length];
}

int getTypeIndex(String title) {
  if (title == type.URGENT_IMPORTANT.name) {
    return 0;
  } else if (title == type.NOT_URGENT_IMPORTANT.name) {
    return 1;
  } else if (title == type.URGENT_NOT_IMPORTANT.name) {
    return 2;
  } else {
    return 3;
  }
}

Widget typeShape(int index, double initialSize, int count) {
  return Stack(
    alignment: Alignment.center,
    children: List.generate(count, (i) {
      return CircleAvatar(
        radius: initialSize - (i * (initialSize / count)),
        backgroundColor:
            (i % 2 == 0) ? getTypeColor(index) : MyTheme.backgroundColor,
      );
    }),
  );
}

Widget dismissableBackground({required Color prefixColor,required Color suffixColor}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          prefixColor,
          suffixColor,
          // Colors.blue.withOpacity(0.7),
          // Colors.red.withOpacity(0.9),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Icon((prefixColor == suffixColor) ? Icons.delete : Icons.archive,
            color: Colors.white),
        const Spacer(),
        const Icon(Icons.delete, color: Colors.white),
      ],
    ),
  );
}
