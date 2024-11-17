import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Task {
  String name;
  Task(this.name);
}

class SwipeTaskList extends StatefulWidget {
  @override
  _SwipeTaskListState createState() => _SwipeTaskListState();
}

class _SwipeTaskListState extends State<SwipeTaskList> {
  List<Task> tasks = [
    Task("Task 1"),
    Task("Task 2"),
    Task("Task 3"),
  ];

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _addTask() {
    setState(() {
      tasks.add(Task("New Task"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe to Delete Task"),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: ValueKey(tasks[index].name), // Unique key for each item
            startActionPane: ActionPane(
              motion: const ScrollMotion(), // Motion style of the sliding
              dismissible: DismissiblePane(onDismissed: () {print('deleted');}), // Optional dismiss on swipe
              children: [
                SlidableAction(
                  onPressed: (context) => _deleteTask(index), // Delete task
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    // Perform archive action here if needed
                    // _archiveTask(index);
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Archive',
                ),
                SlidableAction(
                  onPressed: (context) {
                    // Perform save action here if needed
                    // _saveTask(index);
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.save,
                  label: 'Save',
                ),
              ],
            ),
            child: ListTile(
              title: Text(tasks[index].name),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
