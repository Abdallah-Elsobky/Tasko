import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasko/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:tasko/modules/done_tasks/done_tasks_screen.dart';
import 'package:tasko/modules/new_tasks/new_tasks_screen.dart';
import 'package:tasko/modules/setting/setting.dart';
import 'package:tasko/shared/components/common/database.dart';
import 'package:tasko/shared/components/components.dart';
import 'package:tasko/shared/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import '../modules/new_tasks/widgets/add_task.dart';
import '../shared/components/common/sounds.dart';
import '../shared/components/enums.dart';
import '../shared/styles/styles.dart';
import 'package:restart_app/restart_app.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
  int curindex = 0;

  HomeLayout({int? num}) {
    curindex = num ?? 0;
  }
}

class _HomeLayoutState extends State<HomeLayout> {
  Database? database;
  bool _isWaiting = true;
  @override
  void initState() {
    super.initState();
    initializeDatabase();
    _simulateDelay();
  }



  Future<void> initializeDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database created by data_format');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, time TEXT, type INTEGER, status TEXT, color INTEGER, date_format TEXT)')
            .then((value) {
          print("tasko Table created");
        }).catchError((error) {
          print("Error creating table: $error");
        });
        database
            .execute(
                'CREATE TABLE done (id INTEGER, title TEXT, description TEXT, date TEXT, time TEXT, type INTEGER, status TEXT, color INTEGER, date_format Text)')
            .then((onValue) {
          print("done Table created");
        }).catchError((onError) {
          print("Error creating table: $onError");
        });
        database
            .execute(
                'CREATE TABLE archive (id INTEGER, title TEXT, description TEXT, date TEXT, time TEXT, type INTEGER, status TEXT, color INTEGER, date_format Text)')
            .then((onValue) {
          print("archive Table created");
        }).catchError((onError) {
          print("Error creating table: $onError");
        });
      },
      onOpen: (database) {
        print('Database opened');
      },
    );
    setState(() {});
  }

  Future<void> _simulateDelay() async {
    await Future.delayed(Duration(milliseconds: 2500)); // 1-second delay
    setState(() {
      _isWaiting = false; // Stop waiting after the delay
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_isWaiting && widget.curindex != 3) {
      return Scaffold(
        backgroundColor: MyTheme.backgroundColor,
        body: Center(child: Lottie.asset("assets/lottie/database.json")),
      );
    }

    if(database == null){
      return const Scaffold();
    }

    List<Widget> screens = [
      NewTasksScreen(database: database!),
      DoneTasksScreen(database: database!),
      ArchivedTasksScreen(database: database!),
      Setting(),
    ];

    List<String> titles = ["Tasks", "Done Tasks", "Archived Tasks", "Setting"];

    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyTheme.foregroundColor,
        title: Text(
          titles[widget.curindex],
          style: titleText(color: Colors.white60, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Colors.white,
              size: 30.h,
            ),
            onPressed: () => showAlertDialog(context),
          ),
        ],
      ),
      body: screens[widget.curindex],
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.density_medium,
              color: (widget.curindex == 0)
                  ? Colors.white
                  : MyTheme.backgroundColor),
          Icon(Icons.task_alt,
              color: (widget.curindex == 1)
                  ? Colors.white
                  : MyTheme.backgroundColor),
          Icon(Icons.archive_outlined,
              color: (widget.curindex == 2)
                  ? Colors.white
                  : MyTheme.backgroundColor),
          Icon(Icons.settings,
              color: (widget.curindex == 3)
                  ? Colors.white
                  : MyTheme.backgroundColor),
        ],
        index: widget.curindex,
        onTap: (index) {
          setState(() {
            widget.curindex = index;
          });
        },
        color: MyTheme.foregroundColor,
        buttonBackgroundColor: MyTheme.foregroundColor,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        height: 60,
      ),
    );
  }

  Future<void> deleteDatabaseFile() async {
    try {
      String dbPath = await getDatabasesPath();
      String path = join(dbPath, 'todo.db');

      if (database?.isOpen ?? false) {
        await database?.close();
      }

      await deleteDatabase(path).then((_) {
        print('Database deleted successfully');
      });
    } catch (error) {
      print('Error deleting database: $error');
    }
    setState(() {});
  }

  void showAlertDialog(BuildContext context) {
    click();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyTheme.backgroundColor,
          icon: Icon(
            Icons.dangerous_outlined,
            size: 70.w,
          ),
          iconColor: Colors.red,
          title: Text("Delete all tasks"),
          content: Text("Are you sure?"),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                deleteDatabaseFile();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayout()));
                // Restart.restartApp();
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
