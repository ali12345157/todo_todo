import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_todo/model/task.dart';

class FirebaseUtiles{
static CollectionReference<Task> getTaskscollection(){
  return     FirebaseFirestore.instance.collection('tasks').withConverter<Task>(fromFirestore: ((snapshot,options)=>Task.fromFireStore(snapshot.data()!)),
    toFirestore: (task, options) => task.toFirestore(),);
}
  static Future<void> addtasktofirestore(Task task)
  {

var taskCollectionRef= getTaskscollection();

var taskDocRef =taskCollectionRef.doc();
task.id=taskDocRef.id;
return taskDocRef.set(task);

  }
static Future<void> delete(Task task) async {
  await FirebaseFirestore.instance.collection('tasks').doc(task.id).delete();
  }
static Future<void> update(Task task) async {
  await FirebaseFirestore.instance.collection('tasks').doc(task.id).update(task.toFirestore());
}






}