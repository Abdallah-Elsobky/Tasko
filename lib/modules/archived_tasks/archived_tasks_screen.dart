import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasko/shared/components/common/sounds.dart';

import '../../models/task.dart';
import '../../shared/components/common/database.dart';
import '../../shared/components/common/task_item.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/styles.dart';
import '../../shared/styles/theme.dart';

class ArchivedTasksScreen extends StatefulWidget {
  Database? database;

  ArchivedTasksScreen({required this.database}) {
    this.database = database;
  }

  @override
  State<ArchivedTasksScreen> createState() => _ArchivedTasksScreenState();
}

class _ArchivedTasksScreenState extends State<ArchivedTasksScreen> {
  @override
  void initState() {
    getArchiveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: (archive_tasks.isEmpty)
            ? Opacity(
                opacity: .3,
                child: Lottie.asset("assets/lottie/archive.json"))
            : AnimationLimiter(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      child: SlideAnimation(
                        verticalOffset: 200,
                        child: FadeInAnimation(
                          child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.horizontal,
                              background: dismissableBackground(
                                prefixColor:
                                MyTheme.deleteColor.withOpacity(0.7),
                                suffixColor:
                                MyTheme.deleteColor.withOpacity(0.7),
                              ),
                              onDismissed: (direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  archive();
                                  archive_tasks.add(archive_tasks[index]);
                                  await insertToArchiveTasks(
                                          database: widget.database!,
                                          task: archive_tasks[index],
                                          date_format: DateTime.now().toString())
                                      .then((value) {
                                    deleteTask(archive_tasks[index]);
                                  });
                                } else {
                                  delete();
                                  deleteTask(archive_tasks[index]);
                                }
                              },
                              child: Stack(
                                children: [
                                  buildTaskItem(
                                    task: archive_tasks[index],
                                    database: widget.database!,
                                    color: MyTheme.archiveColor,
                                  ),
                                  Positioned(
                                    right: 10,
                                    bottom: 70,
                                    child: defaultButton(
                                        color: MyTheme.foregroundColor.withOpacity(.8),
                                        text: "Reopen",
                                        width: 100.w,
                                        fontSize: 17,
                                        fun: () async {
                                          reopen();
                                          await toTasks(
                                                  task: archive_tasks[index],
                                                  database: widget.database!)
                                              .then((onValue) {
                                            setState(() {
                                              archive_tasks.removeAt(index);
                                            });
                                          });
                                        }),
                                  )
                                ],
                              )),
                        ),
                      ),
                    );
                  },
                  itemCount: archive_tasks.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 20.h,
                    );
                  },
                ),
            ),
      ),
    );
  }

  void deleteTask(Task task) {
    deleteArchiveTaskDB(task, widget.database!);
    archive_tasks.remove(task.id);
    getArchiveData();
  }

  Future<void> getArchiveData() async {
    clearTasks();
    List<Map<String, dynamic>> tasks =
        await getArchiveFromDatabase(widget.database);
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
        archive_tasks.add(taskObject);
      }
    });
  }
}
