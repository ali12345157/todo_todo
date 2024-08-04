import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_todo/firebase.dart';
import 'package:todo_todo/pro.dart';

import 'model/task.dart'; // To format the date

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit';
  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  DateTime selectedDate = DateTime.now();
late Task args ;
late Pro pro;
  @override
  Widget build(BuildContext context) {

     pro =Provider.of<Pro>(context);
     args=ModalRoute.of(context)?.settings.arguments as Task;
    _titleController.text=args.title;
    _detailsController.text=args.description;
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Edit Task',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'This is title',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _detailsController,
                  decoration: InputDecoration(
                    labelText: 'Task details',
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Select time',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                InkWell(
                  onTap: () => showCalendar(), // Set the method call as a callback
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(args.dateTime),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      update();
                      setState(() {

                      });
                    },
                    child: Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      textStyle: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (chosenDate != null && chosenDate != selectedDate) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }
  void update(){
    args.title=_titleController.text;
    args.description=_detailsController.text;
    FirebaseUtiles.update(args);
    pro.getTasks();
    Navigator.of(context).pop();
    setState(() {

    });
  }
}
