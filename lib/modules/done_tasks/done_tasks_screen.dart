import 'package:tasko/shared/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';
import 'package:easy_stepper/easy_stepper.dart';
import '../../models/task.dart';
import '../../shared/components/common/database.dart';
import '../../shared/components/common/task_item.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/styles.dart';

class DoneTasksScreen extends StatefulWidget {
  Database? database;

  DoneTasksScreen({required this.database}) {
    this.database = database;
  }

  @override
  State<DoneTasksScreen> createState() => _DoneTasksScreenState();
}

class _DoneTasksScreenState extends State<DoneTasksScreen> {
  @override
  void initState() {
    getDoneData();
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
        child: (done_tasks.isEmpty)
            ? Opacity(
                opacity: .3,
                child: Image.asset(flork[random.nextInt(flork.length)]))
            : ListView.separated(
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      background: dismissableBackground(
                        prefixColor:
                        MyTheme.archiveColor.withOpacity(0.9),
                        suffixColor:
                        MyTheme.deleteColor.withOpacity(0.7),
                      ),
                      onDismissed: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          // TODO create archive function delete item from done and add into archive
                          archive_tasks.add(done_tasks[index]);
                          await insertToArchiveTasks(
                                  database: widget.database!,
                                  task: done_tasks[index],
                                  date_format: DateTime.now().toString())
                              .then((value) {
                            deleteTask(done_tasks[index]);
                          });
                        } else {
                          deleteTask(done_tasks[index]);
                        }
                      },
                      child: Stack(
                        children: [
                          buildTaskItem(
                            task: done_tasks[index],
                            database: widget.database!,
                            color: Colors.green,
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
                                  await toTasks(
                                          task: done_tasks[index],
                                          database: widget.database!)
                                      .then((onValue) {
                                    setState(() {
                                      done_tasks.removeAt(index);
                                    });
                                  });
                                }),
                          )
                        ],
                      ));
                },
                itemCount: done_tasks.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 20.h,
                  );
                },
              ),
      ),
    );
  }

  void deleteTask(Task task) {
    deleteDoneTaskDB(task, widget.database!);
    done_tasks.remove(task.id);
    getDoneData();
  }

  Future<void> getDoneData() async {
    clearTasks();
    List<Map<String, dynamic>> tasks =
        await getDoneFromDatabase(widget.database);
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
        done_tasks.add(taskObject);
      }
    });
  }
}
