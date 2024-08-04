import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_todo/app_color.dart';
import 'package:todo_todo/firebase.dart';
import 'package:todo_todo/home_screen.dart';
import 'package:todo_todo/model/task.dart';
import 'package:todo_todo/pro.dart';

import 'edit.dart';
import 'isdone.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  TaskListItem({required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  void initState() {
    super.initState();
    // Call getTasks in initState if needed
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(15),
            onPressed: (context) {
              _showDeleteDialog(context); // Show confirmation dialog
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(15),
            onPressed: (context) {
              Navigator.pushNamed(context, EditTaskScreen.routeName, arguments: widget.task);
            },
            backgroundColor: const Color(0xFF06F13D),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.whitecolor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              color: AppColor.primaryColor,
              width: 4,
              height: 80,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: const TextStyle(
                      color: Color(0xff5D9CEC),
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    widget.task.description,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: AppColor.primaryColor,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ToDoListScreen.routeName,
                    arguments: widget.task,
                  );
                },
                icon: Icon(
                  Icons.check,
                  size: 35,
                  color: AppColor.whitecolor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    var listpro =Provider.of<Pro>(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: Text('Are you sure you want to delete "${widget.task.title}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseUtiles.delete(widget.task).timeout(Duration(milliseconds: 500)); // Perform the actual deletion
               listpro.getTasks(); // Close the dialog
                setState(() {

                });
                // Optionally, notify the parent widget or refresh the list
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
