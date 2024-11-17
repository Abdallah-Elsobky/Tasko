import 'dart:math';

import 'package:tasko/shared/components/common/database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/task.dart';
import 'package:flutter/material.dart';

import '../../styles/styles.dart';
import '../../styles/theme.dart';
import '../components.dart';

final Random random = Random();
final containerWidth = double.infinity;
final containerHeight = 200.0.h;
final int min = 20;
final int max = 150;
int rand = 100;

Widget buildTaskItem({required Task task, required Database database , Color color = Colors.green}) {
  rand = random.nextInt(1234);
  return Container(
    height: containerHeight,
    width: containerWidth,
    decoration: BoxDecoration(
      color: Colors.blue.withOpacity(0.9),
      borderRadius: BorderRadius.circular(20.0),
      gradient: LinearGradient(
        colors: [
          Colors.black87.withOpacity(1),
          Colors.black12.withOpacity(0.1)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Stack(
      children: [
        Stack(
            children: List.generate(1, (index) {
              return Positioned(
                top: -10,
                right: -80,
                bottom: -10,
                child: Transform.rotate(
                  angle: random.nextDouble() * 2 * pi,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      images[(rand + task.id) % images.length],
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
              );
            })),
        Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Text(
                          task.title,
                          overflow: TextOverflow.ellipsis,
                          style: titleText(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(''),
                        // GestureDetector(
                        //   onTap: () {
                        //     _toggleBottomSheet(task: task);
                        //   },
                        //   child: const CircleAvatar(
                        //     backgroundColor: Colors.black26,
                        //     child: Icon(
                        //       Icons.edit,
                        //       color: MyTheme.backgroundColor,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 85.h,
                          width: 320.w,
                          child: Text(
                            task.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: titleText(
                                color: Colors.white60, fontSize: 16),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(''),
                        // defaultButton(
                        //   color: const Color(0xFF95B567),
                        //   text: 'done',
                        //   fun: () async {
                        //     await insertToDoneTasks(
                        //             database: widget.database!,
                        //             task: task,
                        //             date_format: DateTime.now().toString())
                        //         .then((value) {
                        //       deleteTask(task);
                        //     });
                        //   },
                        //   width: 100.w,
                        //   fontSize: 15,
                        // ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(13.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            task.date,
                            style: titleText(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(13.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            task.time,
                            style: titleText(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
