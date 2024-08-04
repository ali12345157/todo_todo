import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_todo/model/task.dart';

import 'firebase.dart';

class Pro extends ChangeNotifier{

  List<Task> taskslist = [

    // Add more tasks as needed
  ];
  DateTime selectDate =DateTime.now();
  Future<void> getTasks() async {

    QuerySnapshot<Task> Snapshot = await FirebaseUtiles.getTaskscollection().get();

    List<QueryDocumentSnapshot<Task>> list = Snapshot.docs;
    taskslist=list.map((task){
      return task.data();
    }).toList();
   taskslist= taskslist.where((task) {
      if(selectDate.day==task.dateTime.day&&selectDate.month==task.dateTime.month&&selectDate.year==task.dateTime.year){

        return true;





      }
      return false;

    } ,).toList();
   taskslist.sort((Task task1,Task task2){
     return task1.dateTime.compareTo(task2.dateTime);
   });

notifyListeners();
    // Do something with querySnapshot if needed
  }
  void changeSelectDate(DateTime newSelectDate){
    selectDate=newSelectDate;
    getTasks();
    notifyListeners();
  }
  Future<void> update(Task task )
  async {
   CollectionReference<Task> user =  await FirebaseUtiles.getTaskscollection();

   var taskCollectionRef= FirebaseUtiles.getTaskscollection();

   var taskDocRef =taskCollectionRef.doc(task.id);

   return taskDocRef.update(task.toFirestore());

  }

  }

