import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';
import 'package:todo_app/component/restart_widget.dart';
import 'package:todo_app/pages/homepage.dart';

// import 'assets/style/style.dart';

void main(List<String> args) async {
  // initialize flutter to database
  await Hive.initFlutter();

  //open the box, box is like database mungkin
  var taskData = await Hive.openBox('taskData');
  var themeData = await Hive.openBox('themeData');

  runApp(const RestartWidget(
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _myBox.put(key, value);
    // Homepage.switchTheme();
    
  
    return const MaterialApp(
      title: 'ToDo app',
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
