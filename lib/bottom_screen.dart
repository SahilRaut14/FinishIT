import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finishit/commonbox.dart';
import 'package:provider/provider.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({Key? key}) : super(key: key);

  @override
  _BottomSheetScreenState createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  String? newTaskTitle;
  String? description; // Declare description without initializing
  DateTime selectedEndDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepPurple, fontSize: 30.0),
          ),
          TextField(
            textAlign: TextAlign.center,
            autofocus: true,
            cursorColor: Colors.deepPurple,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurpleAccent),
              ),
            ),
            onChanged: (value) {
              setState(() {
                newTaskTitle = value;
              });
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () async {
              final pickedEndDate = await showDatePicker(
                context: context,
                initialDate: selectedEndDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (pickedEndDate != null) {
                setState(() {
                  selectedEndDate = pickedEndDate;
                });
              }
            },
            child: Row(
              children: [
                const Icon(Icons.date_range),
                Text(
                  'Due Date: ${DateFormat('yyyy-MM-dd').format(selectedEndDate)}',
                ),
              ],
            ),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Description'),
            onChanged: (value) {
              setState(() {
                description = value; // Update description
              });
            },
          ),
          // Slider(
          //   value: priority,
          //   min: 0,
          //   max: 10,
          //   divisions: 10,
          //   label: 'Priority: ${priority.toInt()}',
          //   onChanged: (double value) {
          //     setState(() {
          //       priority = value; // Update priority
          //     });
          //   },
          // ),
          TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.deepPurpleAccent),
            ),
            onPressed: () {
              if (newTaskTitle != null) {
                Provider.of<CommonBox>(context, listen: false).addTask(
                  newTaskTitle!,
                  description ?? '', // Pass description directly
                  selectedEndDate,
                );
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
