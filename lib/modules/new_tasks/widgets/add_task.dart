import 'package:tasko/shared/components/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';
import '../../../models/task.dart';
import '../../../shared/components/common/database.dart';
import '../../../shared/components/common/drop_list.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/styles.dart';
import '../../../shared/styles/theme.dart';

class AddNewTaskScreen extends StatefulWidget {
  Database? database;
  Task? task;

  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();

  AddNewTaskScreen({required this.database, this.task});
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int selectedColor = 0;
  int type_index = 0;
  int old_type_index = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.utc(DateTime.now().year + 1),
        ) ??
        selectedDate;

    setState(() {
      selectedDate = pickedDate;
      dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        timeController.text = "${selectedTime.format(context)}";
      });
    }
  }

  bool isTimeFalse() {
    if ("${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}" ==
            dateController.text &&
        selectedTime.hour < TimeOfDay.now().hour) {
      return true;
    }
    return false;
  }

  void editTask(Task? task) {
    if (task != null) {
      setState(() {
        titleController.text = task.title;
        descriptionController.text = task.description;
        dateController.text = task.date;
        timeController.text = task.time;
        selectedDate = DateTime.parse(task.date_format);
        selectedTime = TimeOfDay.fromDateTime(selectedDate);
        type_index = task.type;
        old_type_index = task.type;
        selectedColor = task.color;
      });
    }
  }

  @override
  void initState() {
    print('init');
    editTask(widget.task);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 610.h,
      decoration: BoxDecoration(
        color: MyTheme.dialogColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
        border: Border.all(width: 2, color: MyTheme.foregroundColor),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    defaultTextFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      label: "Title",
                      prefix: Icons.title,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Title must not be empty";
                        } else if (value.length > 25) {
                          return "Title must not be more than 25 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    defaultTextFormField(
                      controller: descriptionController,
                      type: TextInputType.text,
                      label: "Description",
                      prefix: Icons.description,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Description must not be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Date Picker Field
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: defaultTextFormField(
                                controller: dateController,
                                type: TextInputType.datetime,
                                label: "Date",
                                prefix: Icons.calendar_today,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Date must not be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectTime(context),
                            child: AbsorbPointer(
                              child: defaultTextFormField(
                                controller: timeController,
                                type: TextInputType.datetime,
                                label: "Time",
                                prefix: Icons.watch_later,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Time must not be empty";
                                  } else if (isTimeFalse()) {
                                    return "Select a Future Time";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomDropdown(
                      items: [
                        type.URGENT_IMPORTANT.name,
                        type.NOT_URGENT_IMPORTANT.name,
                        type.URGENT_NOT_IMPORTANT.name,
                        type.NOT_URGENT_NOT_IMPORTANT.name
                      ],
                      selectedValue: type_index,
                      hint: "Select task type",
                      onChanged: (value) {
                        setState(() {
                          type_index = getType(value!);
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: MyTheme.backgroundColor.color.withOpacity(.6),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Task color',
                            style: labelText(),
                          ),
                          SizedBox(
                            height: 80.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 14,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 23.r,
                                      backgroundColor:
                                          task_colors[index].withOpacity(.3),
                                      child: CircleAvatar(
                                        radius: (selectedColor == index)
                                            ? 20.r
                                            : 0.r,
                                        backgroundColor: task_colors[index],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    defaultButton(
                      text: (widget.task != null) ? 'Update' : 'Add',
                      color: (widget.task != null)
                          ? Colors.green.withOpacity(.7)
                          : MyTheme.foregroundColor.withOpacity(.9),
                      fun: () async {
                        await createDatabase(widget.database);
                        if (_formKey.currentState!.validate()) {
                          if (widget.task != null) {
                            if (old_type_index != type_index) {
                              getTasksByPriority(type_index)[widget.task!.id] =
                                  widget.task!;
                              getTasksByPriority(old_type_index)
                                  .remove(widget.task!.id);
                            }
                            await updateTask(
                                    id: widget.task!.id,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    date: dateController.text,
                                    time: timeController.text,
                                    type: type_index,
                                    color: selectedColor)
                                .then((_) {
                              Navigator.pop(context);
                            }).catchError((error) {
                              print("Error: $error");
                            });
                            ;
                          } else {
                            await insertToTasks(
                                    database: widget.database!,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    date: dateController.text,
                                    time: timeController.text,
                                    type: type_index,
                                    color: selectedColor,
                                    date_format: selectedDate.toString())
                                .then((_) {
                              Navigator.pop(context);
                            }).catchError((error) {
                              print("Error: $error");
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> insertToDatabase({
  //   required String title,
  //   required String description,
  //   required String date,
  //   required String time,
  //   required int type,
  //   required int color,
  //   required String date_format,
  // }) async {
  //   await widget.database?.transaction((txn) async {
  //     await txn.rawInsert(
  //       'INSERT INTO tasks (title, description, date, time, type, status, color, date_format) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
  //       [
  //         title,
  //         description,
  //         date,
  //         time,
  //         type,
  //         status.TODO.name.toLowerCase(),
  //         color,
  //         date_format,
  //       ],
  //     ).then((onValue) {
  //       print('Row $onValue inserted successfully');
  //     }).catchError((onError) {
  //       print('Error inserting: $onError');
  //     });
  //   });
  // }

  // Future<void> createDatabase() async {
  //   widget.database = await openDatabase(
  //     'todo.db',
  //     version: 1,
  //     onCreate: (database, version) {
  //       print('Database created');
  //       database
  //           .execute(
  //               'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, time TEXT, type INTEGER, status TEXT, color INTEGER, date_format Text)')
  //           .then((onValue) {
  //         print("Table created");
  //       }).catchError((onError) {
  //         print("Error creating table: $onError");
  //       });
  //     },
  //     onOpen: (database) {
  //       print('Database opened');
  //     },
  //   );
  // }

  Future<void> updateTask({
    required int id,
    required String title,
    required String description,
    required String date,
    required String time,
    required int type,
    required int color,
  }) async {
    print('before update');
    await widget.database?.rawUpdate(
        'UPDATE tasks SET title = ?, description = ?, date = ?, time = ?, type = ?, status = ?, color = ? WHERE id = ?',
        [
          title,
          description,
          date,
          time,
          type,
          status.TODO.name.toLowerCase(),
          color,
          id,
        ]);
    print('after update');
  }
}
