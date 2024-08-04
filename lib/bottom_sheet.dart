import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_todo/firebase.dart';
import 'package:todo_todo/model/task.dart';
import 'package:todo_todo/pro.dart';
import 'app_color.dart';

class Bottom extends StatefulWidget {
  Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  var selectedate = DateTime.now();

  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late Pro listpro;

  @override
  Widget build(BuildContext context) {
     listpro =Provider.of<Pro>(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add New Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Enter task title"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Please enter task title";
                    }
                    return null;
                  },
                  onChanged: (text) {
                    title = text;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(hintText: "Enter Description"),
                  maxLines: 4,
                  onChanged: (text) {
                    description = text;
                  },
                ),
                Text('Select date'),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    showCalander();
                  },
                  child: Text('${selectedate.day}/${selectedate.month}/${selectedate.year}'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    addTask();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor, // Background color
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white), // Text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCalander() async {
    var chosendate = await showDatePicker(
      context: context,
      initialDate: selectedate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (chosendate != null) {
      setState(() {
        selectedate = chosendate;
      });
    }
  }

  void addTask() {
    if (formKey.currentState!.validate()) {
      Task task = Task(title: title, description: description, dateTime: selectedate);
      FirebaseUtiles.addtasktofirestore(task).timeout(Duration(seconds: 1), onTimeout: () {
        print('Task added successfully');
listpro.getTasks();
        Navigator.pop(context);
      });
    }
  }
}
