import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_todo/pro.dart';
import 'package:todo_todo/splash_screen.dart';
import 'edit.dart';
import 'home_screen.dart';
import 'isdone.dart';
import 'my_theme.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid?await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyC_yDZ7lQn77n_IQlkXihzGt48ZVFJLAGU", appId: "com.example.todo_todo", messagingSenderId: "643755936097", projectId: "todotodo-d6a54")):
  await Firebase.initializeApp(


  );
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(create:(context) => Pro(),child: Myapp()));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(theme: MyThemeData.LightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute:SplashScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          SplashScreen.routeName:(context)=>SplashScreen(),
          ToDoListScreen.routeName:(context)=>ToDoListScreen(),
          EditTaskScreen.routeName:(context)=>EditTaskScreen()
        }
        );
  }
}
