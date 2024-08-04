class Task{

  String id;
  String title;
  String description;
  DateTime dateTime;
  bool idDone ;

Task({this.id ='',required this.title,required this.description,required this.dateTime,this.idDone=false});
Task.fromFireStore(Map<String,dynamic> data):this(
  id: data['id'],
    title:data['title'] ,
  description: data['description'],
  dateTime: DateTime.fromMillisecondsSinceEpoch(data['datetime']),
  idDone:data['isDone']
);

Map<String,dynamic>toFirestore(){
return {
  'id':id,
  'title':title,
  'description':description,
  'datetime':dateTime.millisecondsSinceEpoch,
  'isDone':idDone
};



}



}