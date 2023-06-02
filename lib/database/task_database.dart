import 'package:hive/hive.dart';

class TaskDatabase{

  List taskList = [];
  
  var database = Hive.box('taskData'); 

  void initializeFirstData(){
    taskList = [
    ['do exercise', false],
    ['do Homework', true]
  ];
  }

  void loadData(){
    taskList = database.get('taskList');
  }

  void updateData(){
    database.put('taskList', taskList);
  }

  List taskCompleted(){
    return taskList.where((element) => element[1] == true).toList();
  }

  List taskUncompleted(){
    return taskList.where((element) => element[1] == false).toList();
  }

}