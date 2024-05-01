import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finishit/bottom_screen.dart';
import 'package:finishit/commonbox.dart';
import 'package:finishit/task_tile.dart';

class TaskScreen extends StatelessWidget {
  static const String id = 'task_screen';

  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 10.0),
                child: BottomSheetScreen(),
              );
            },
          );
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 50.0, bottom: 30.0, left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: Icon(
                    Icons.list,
                    color: Colors.lightBlue,
                    size: 40.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'To Doey!',
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text('${Provider.of<CommonBox>(context).taskCount} Tasks',
                    style:
                        const TextStyle(color: Colors.white, fontSize: 18.0)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: const TaskList(),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commonBox = Provider.of<CommonBox>(context);
    final tasks = commonBox.tasks;

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        commonBox.reorderTasks(oldIndex, newIndex);
      },
      children: tasks.map((task) {
        return TaskTile(
          taskTitle: task.name,
          isChecked: task.isDone,
          checkBoxCallBack: (isChecked) {
            commonBox.updateTask(task);
          },
          longPressCallBack: () {
            commonBox.deleteTask(task);
          },
          description: task.description,
          endDate: task.endDate,
          priority: task.priority,
        );
      }).toList(),
    );
  }
}
