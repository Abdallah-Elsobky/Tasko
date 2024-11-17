import 'package:sqflite/sqflite.dart';

import '../../../models/task.dart';
import '../components.dart';
import '../enums.dart';

Database? db;

Future<void> createDatabase(Database? database) async {
  database = await openDatabase(
    'todo.db',
    version: 1,
    onCreate: (database, version) {
      print('Database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, time TEXT, type INTEGER, status TEXT, color INTEGER, date_format Text)')
          .then((onValue) {
        print("task Table created");
      }).catchError((onError) {
        print("Error creating table: $onError");
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
      db = database;
    },
  );
}

Future<void> insertToTasks({
  required Database database,
  required String title,
  required String description,
  required String date,
  required String time,
  required int type,
  required int color,
  required String date_format,
}) async {
  await database.transaction((txn) async {
    await txn.rawInsert(
      'INSERT INTO tasks (title, description, date, time, type, status, color, date_format) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [
        title,
        description,
        date,
        time,
        type,
        status.TODO.name.toLowerCase(),
        color,
        date_format,
      ],
    ).then((onValue) {
      print('Row $onValue inserted successfully');
    }).catchError((onError) {
      print('Error inserting: $onError');
    });
  });
}

Future<void> insertToDoneTasks({
  required Database database,
  required Task task,
  required String date_format,
}) async {
  await database.transaction((txn) async {
    task.date_format = date_format;
    await txn.rawInsert(
      'INSERT INTO done (id, title, description, date, time, type, status, color, date_format) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?)',
      [
        task.id,
        task.title,
        task.description,
        task.date,
        task.time,
        task.type,
        status.DONE.name.toLowerCase(),
        task.color,
        date_format,
      ],
    ).then((onValue) {
      print('Row $onValue done successfully');
    }).catchError((onError) {
      print('Error inserting: $onError');
    });
  });
}

Future<void> insertToArchiveTasks({
  required Database database,
  required Task task,
  required String date_format,
}) async {
  await database.transaction((txn) async {
    task.date_format = date_format;
    await txn.rawInsert(
      'INSERT INTO archive (id, title, description, date, time, type, status, color, date_format) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        task.id,
        task.title,
        task.description,
        task.date,
        task.time,
        task.type,
        status.ARCHIVE.name.toLowerCase(),
        task.color,
        date_format,
      ],
    ).then((onValue) {
      print('Row $onValue archived successfully');
    }).catchError((onError) {
      print('Error inserting: $onError');
    });
  });
}

Future<List<Map<String, dynamic>>> getTasksFromDatabase(
    Database? database) async {
  List<Map<String, dynamic>> tasks = [];
  await createDatabase(database);
  print('call get Tasks');
  print(database == null || !database.isOpen);
  if (database == null || !database.isOpen) return tasks;

  try {
    print('get data is run');
    tasks = await database.query('tasks', orderBy: 'type ASC');
  } catch (error) {
    print('Error fetching tasks: $error');
  }
  return tasks;
}

Future<List<Map<String, dynamic>>> getDoneFromDatabase(
    Database? database) async {
  List<Map<String, dynamic>> tasks = [];
  await createDatabase(database);
  print('call get Tasks');
  print(database == null || !database.isOpen);
  if (database == null || !database.isOpen) return tasks;

  try {
    print('get data is run');
    tasks = await database.query('done', orderBy: 'type ASC');
  } catch (error) {
    print('Error fetching tasks: $error');
  }
  return tasks;
}

Future<List<Map<String, dynamic>>> getArchiveFromDatabase(
    Database? database) async {
  List<Map<String, dynamic>> tasks = [];
  await createDatabase(database);
  print('call get Tasks');
  print(database == null || !database.isOpen);
  if (database == null || !database.isOpen) return tasks;

  try {
    print('get data is run');
    tasks = await database.query('archive', orderBy: 'type ASC');
  } catch (error) {
    print('Error fetching tasks: $error');
  }
  return tasks;
}

Future<void> deleteTaskDB(Task task, Database database) async {
  if (database == null || !database.isOpen) {
    print('Not found database to delete task!!');
    return;
  }
  try {
    print('delete task ${task.id}');
    await database.rawDelete(
      'DELETE from tasks WHERE id = ${task.id}',
    );
  } catch (error) {
    print('Error delete task: $error');
  }
}

Future<void> deleteDoneTaskDB(Task task, Database database) async {
  if (database == null || !database.isOpen) {
    print('Not found database to delete task!!');
    return;
  }
  try {
    print('delete done ${task.id}');
    await database.rawDelete(
      'DELETE from done WHERE id = ${task.id}',
    );
  } catch (error) {
    print('Error delete task: $error');
  }
}

Future<void> deleteArchiveTaskDB(Task task, Database database) async {
  if (database == null || !database.isOpen) {
    print('Not found database to delete task!!');
    return;
  }
  try {
    print('delete archive ${task.id}');
    await database.rawDelete(
      'DELETE from archive WHERE id = ${task.id}',
    );
  } catch (error) {
    print('Error delete task: $error');
  }
}

Future<void> toTasks({required Task task, required Database database}) async {
  await insertToTasks(
          database: database,
          title: task.title,
          description: task.description,
          date: task.date,
          time: task.time,
          type: task.type,
          color: task.color,
          date_format: task.date_format)
      .then((value) {
    (task.status == status.DONE.name.toLowerCase())
        ? deleteDoneTaskDB(task, database)
        : deleteArchiveTaskDB(task, database);
  });
}

Database getDatabase() {
  return db!;
}
