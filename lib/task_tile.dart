import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {super.key,
      required this.taskTitle,
      required this.isChecked,
      required this.checkBoxCallBack,
      required this.longPressCallBack,
      required this.description,
      required this.endDate,
      required this.priority});

  final String taskTitle;
  final bool isChecked;
  final Function(bool?) checkBoxCallBack;
  final Function() longPressCallBack;
  final String? description;
  final DateTime? endDate;
  final int? priority;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallBack,
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (description != null) Text(description!),
          if (endDate != null)
            Text('Due Date: ${DateFormat('yyyy-MM-dd').format(endDate!)}'),
          if (priority != null) Text('Priority: $priority'),
        ],
      ),
      trailing: Checkbox(
        onChanged: checkBoxCallBack,
        value: isChecked,
        fillColor: const MaterialStatePropertyAll(Colors.lightBlueAccent),
        checkColor: Colors.white,
      ),
    );
  }
}
