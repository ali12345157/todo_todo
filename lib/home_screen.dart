// HomeScreen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_todo/model/task.dart';
import 'package:todo_todo/pro.dart';
import 'Task_list_item.dart';
import 'bottom_sheet.dart'; // Ensure this import is correct
import 'app_color.dart';
import 'firebase.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;

  List<Widget> taps = [TaskListTap(), Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selected,
          onTap: (index) {
            setState(() {
              selected = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list, size: 20),
              label: "Task List",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 20),
              label: "Task Settings",
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        title: Text(
          "To Do List",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.18,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: taps[selected]),
          ],
        ),
      ),
    );
  }

  void addTask() {
    showModalBottomSheet(context: context, builder: (context) => Bottom());
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
        ],
      ),
    );
  }
}

class TaskListTap extends StatefulWidget {
  @override
  State<TaskListTap> createState() => _TaskListTapState();
}

class _TaskListTapState extends State<TaskListTap> {


  @override
  Widget build(BuildContext context) {
    var listpro =Provider.of<Pro>(context);
    if(listpro.taskslist.isEmpty){
     listpro.getTasks() ;
    }
    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: listpro.selectDate,
            onDateChange: (selectedDate) {
              listpro.changeSelectDate(selectedDate);
              // Handle the selected date change
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff8426D6),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:listpro.taskslist.length,
              itemBuilder: (context, index) {
                return TaskListItem(task: listpro.taskslist[index]);
              },
            ),
          ),
        ],
      ),
    );
  }


}