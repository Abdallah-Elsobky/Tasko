import 'dart:math';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tasko/modules/new_tasks/widgets/add_task.dart';
import 'package:tasko/shared/components/common/database.dart';
import 'package:tasko/shared/components/common/task_item.dart';
import 'package:tasko/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/task.dart';
import '../../shared/components/common/sounds.dart';
import '../../shared/styles/styles.dart';
import '../../shared/styles/theme.dart';

class NewTasksScreen extends StatefulWidget {
  Database? database;

  NewTasksScreen({Key? key, required this.database}) : super(key: key);

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  final Random random = Random();
  final containerWidth = double.infinity;
  final containerHeight = 200.0.h;
  final int min = 20;
  final int max = 150;
  int rand = 100;
  bool isBottomSheetShown = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Icon sheetIcon = const Icon(Icons.edit);

  @override
  void initState() {
    super.initState();
    getTaskData();
  }

  @override
  Widget build(BuildContext context) {
    rand = random.nextInt(10223);
    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      key: scaffoldKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      typeShape(index, 15, 3),
                      SizedBox(width: 10.w),
                      Text(
                        task_types[index],
                        style: taskText(),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Column(
                    children: (getTasksByPriority(index).length == 0)
                        ? [
                            Opacity(
                              opacity: .2,
                              child: Image.asset(
                                flork[(rand + index) % flork.length],
                                height: 90.h,
                                width: 90.w,
                              ),
                            ),
                          ]
                        : [
                            AnimationLimiter(
                                child: Column(
                              children: getTasksByPriority(index)
                                  .entries
                                  .map((entry) {
                                Task task = entry
                                    .value; // Access task from the map entry
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 800),
                                  child: SlideAnimation(
                                    verticalOffset: 200.0,
                                    child: FadeInAnimation(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              typeShape(index, 8, 5),
                                              Container(
                                                height: containerHeight,
                                                width: 2,
                                                color: Colors.black26,
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Dismissible(
                                              key: UniqueKey(),
                                              // Use the task's ID as a unique key
                                              direction:
                                                  DismissDirection.horizontal,
                                              background: dismissableBackground(
                                                prefixColor: MyTheme
                                                    .archiveColor
                                                    .withOpacity(0.9),
                                                suffixColor: MyTheme.deleteColor
                                                    .withOpacity(0.7),
                                              ),
                                              onDismissed: (direction) async {
                                                if (direction ==
                                                    DismissDirection
                                                        .startToEnd) {
                                                  archive();
                                                  archive_tasks.add(task);
                                                  await insertToArchiveTasks(
                                                          database:
                                                              widget.database!,
                                                          task: task,
                                                          date_format:
                                                              DateTime.now()
                                                                  .toString())
                                                      .then((value) {
                                                    deleteTask(task);
                                                  });
                                                } else {
                                                  delete();
                                                  deleteTask(task);
                                                }
                                              },
                                              // Use `entry.key` and `task`
                                              child: Stack(
                                                children: [
                                                  buildTaskItem(
                                                      task: task,
                                                      database:
                                                          widget.database!,
                                                      color: getTaskColor(
                                                          task.color)),
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _toggleBottomSheet(
                                                            task: task);
                                                      },
                                                      child: const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.black26,
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: MyTheme
                                                              .backgroundColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 5,
                                                    bottom: 60,
                                                    child: defaultButton(
                                                      color: Color.lerp(
                                                          getTaskColor(
                                                              task.color),
                                                          Colors.black,
                                                          .4)!,
                                                      text: 'done',
                                                      fun: () async {
                                                        done();
                                                        await insertToDoneTasks(
                                                                database: widget
                                                                    .database!,
                                                                task: task,
                                                                date_format: DateTime
                                                                        .now()
                                                                    .toString())
                                                            .then((value) {
                                                          deleteTask(task);
                                                        });
                                                      },
                                                      width: 100.w,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ), // Build the task item
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ))
                          ],
                  ),
                ],
              );
            },
            itemCount: task_types.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 20.h);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.foregroundColor,
        foregroundColor: MyTheme.backgroundColor,
        onPressed: _toggleBottomSheet,
        child: sheetIcon,
      ),
    );
  }

  Future<void> getTaskData() async {
    clearTasks();
    List<Map<String, dynamic>> tasks =
        await getTasksFromDatabase(widget.database);
    setState(() {
      for (var task in tasks) {
        Task taskObject = Task(
            id: task['id'],
            title: task['title'],
            description: task['description'],
            date: task['date'],
            time: task['time'],
            status: task['status'],
            type: task['type'],
            color: task['color'],
            date_format: task['date_format']);
        switch (task['type']) {
          case 0:
            priority1_tasks[taskObject.id] = taskObject;
            break;
          case 1:
            priority2_tasks[taskObject.id] = taskObject;

            break;
          case 2:
            priority3_tasks[taskObject.id] = taskObject;

            break;
          case 3:
            priority4_tasks[taskObject.id] = taskObject;

            break;
        }
      }
    });
  }

  void _toggleBottomSheet({Task? task}) {
    click();
    if (isBottomSheetShown) {
      isBottomSheetShown = false;
      sheetIcon = const Icon(Icons.edit);
      Navigator.pop(context);
    } else {
      scaffoldKey.currentState
          ?.showBottomSheet(
            (context) => AddNewTaskScreen(
              database: widget.database,
              task: task,
            ),
            backgroundColor: MyTheme.backgroundColor,
          )
          .closed
          .then((_) async {
        await getTaskData();
        setState(() {
          isBottomSheetShown = false;
          sheetIcon = const Icon(Icons.edit);
        });
      });
      setState(() {
        isBottomSheetShown = true;
        sheetIcon = const Icon(Icons.close);
      });
    }
  }

  // Widget buildTaskItm(Task task) {
  //   return Container(
  //     height: containerHeight,
  //     width: containerWidth,
  //     decoration: BoxDecoration(
  //       color: Colors.blue.withOpacity(0.9),
  //       borderRadius: BorderRadius.circular(20.0),
  //       gradient: LinearGradient(
  //         colors: [
  //           Colors.black87.withOpacity(1),
  //           Colors.black12.withOpacity(0.1)
  //         ],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //     ),
  //     child: Stack(
  //       children: [
  //         Stack(
  //             children: List.generate(1, (index) {
  //           return Positioned(
  //             top: -10,
  //             right: -80,
  //             bottom: -10,
  //             child: Transform.rotate(
  //               angle: random.nextDouble() * 2 * pi,
  //               child: Opacity(
  //                 opacity: 0.2,
  //                 child: Image.asset(
  //                   images[(rand + task.id) % images.length],
  //                   height: 300,
  //                   width: 300,
  //                 ),
  //               ),
  //             ),
  //           );
  //         })),
  //         Container(
  //           height: containerHeight,
  //           width: containerWidth,
  //           decoration: BoxDecoration(
  //             color: getTaskColor(task.color).withOpacity(0.5),
  //             borderRadius: BorderRadius.circular(20.0),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               children: [
  //                 Expanded(
  //                   flex: 1,
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         flex: 9,
  //                         child: Text(
  //                           task.title,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: titleText(
  //                             color: Colors.white.withOpacity(0.9),
  //                             fontSize: 22,
  //                           ),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         flex: 1,
  //                         child: Text(''),
  //                         // GestureDetector(
  //                         //   onTap: () {
  //                         //     _toggleBottomSheet(task: task);
  //                         //   },
  //                         //   child: const CircleAvatar(
  //                         //     backgroundColor: Colors.black26,
  //                         //     child: Icon(
  //                         //       Icons.edit,
  //                         //       color: MyTheme.backgroundColor,
  //                         //     ),
  //                         //   ),
  //                         // ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(
  //                   flex: 3,
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         flex: 3,
  //                         child: Container(
  //                           height: 85.h,
  //                           width: 320.w,
  //                           child: Text(
  //                             task.description,
  //                             maxLines: 3,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: titleText(
  //                                 color: Colors.white60, fontSize: 16),
  //                           ),
  //                         ),
  //                       ),
  //                       Expanded(
  //                         flex: 1,
  //                         child: Text(''),
  //                         // defaultButton(
  //                         //   color: const Color(0xFF95B567),
  //                         //   text: 'done',
  //                         //   fun: () async {
  //                         //     await insertToDoneTasks(
  //                         //             database: widget.database!,
  //                         //             task: task,
  //                         //             date_format: DateTime.now().toString())
  //                         //         .then((value) {
  //                         //       deleteTask(task);
  //                         //     });
  //                         //   },
  //                         //   width: 100.w,
  //                         //   fontSize: 15,
  //                         // ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(
  //                   flex: 1,
  //                   child: Row(
  //                     children: [
  //                       Container(
  //                         decoration: BoxDecoration(
  //                           color: Colors.black26,
  //                           borderRadius: BorderRadius.circular(13.r),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(5.0),
  //                           child: Text(
  //                             task.date,
  //                             style: titleText(
  //                               color: Colors.white,
  //                               fontSize: 15,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Spacer(),
  //                       Container(
  //                         decoration: BoxDecoration(
  //                           color: Colors.black26,
  //                           borderRadius: BorderRadius.circular(13.r),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(5.0),
  //                           child: Text(
  //                             task.time,
  //                             style: titleText(
  //                               color: Colors.white,
  //                               fontSize: 15,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void deleteTask(Task task) {
    deleteTaskDB(task, widget.database!);
    setState(() {
      getTasksByPriority(task.type).remove(task.id);
    });
  }
}
