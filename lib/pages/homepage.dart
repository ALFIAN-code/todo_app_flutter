import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/assets/style/style.dart';
import 'package:todo_app/database/task_database.dart';
// import 'package:todo_app/component/appbar.dart';

import '../component/light_dark_toggle.dart';
import '../component/search_bar.dart';
import '../component/task_box.dart';
import '../component/task_box_complete.dart';
// import 'content.dart';

var taskData = Hive.box('taskData');

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController controller = TextEditingController();

  TaskDatabase taskDB = TaskDatabase();

  var themeData = Hive.box('themeData');

  @override
  void initState() {
    super.initState();
    if (taskData.get('taskList') == null) {
      taskDB.initializeFirstData();
      themeData.put('state', 0);
      // taskDB.updateData();
    } else {
      // taskData.deleteFromDisk();
      taskDB.loadData();
    }
    initializeTheme();
  }

  void initializeTheme() {
    setState(() {
      AppColor.switchTheme();
    });
  }

  void addData(String taskName) {
    setState(() {
      if (taskDB.taskList
          .where((element) => element[0] == taskName)
          .toList()
          .isEmpty) {
        taskDB.taskList.add([taskName, false]);
        taskDB.updateData();
        controller.clear();
      }
    });
  }

  void checkboxChange(bool? value, String taskName) {
    setState(() {
      taskDB.taskList.where((element) => element[0] == taskName).first[1] =
          !taskDB.taskList.where((element) => element[0] == taskName).first[1];
      taskDB.updateData();
    });
  }

  void deleteTask(String taskName) {
    setState(() {
      taskDB.taskList.removeWhere((element) => element[0] == taskName);
      taskDB.updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    List taskUncomplete = taskDB.taskUncompleted();

    var deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                      floating: false,
                      snap: false,
                      // expandedHeight: deviceHeight * 0.1,
                      toolbarHeight: deviceHeight * 0.1,
                      backgroundColor: AppColor.primaryColor,
                      elevation: 0,
                      flexibleSpace: Container(
                          margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/assets/images/profile.png',
                                height: 40,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'HI Alfian',
                                      style: bold21.copyWith(
                                          color: AppColor.textColor),
                                    ),
                                    Text(
                                      '${taskUncomplete.length} task remaning',
                                      style: regular13.copyWith(
                                          color: AppColor.accentOrange),
                                    )
                                  ],
                                ),
                              ),
                              // ToggleButtons(children: [], isSelected:)
                              const LightDarkToggle()
                            ],
                          ))),
                ],
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Searchbar(),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                      child: ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: AppColor.secondaryColor,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Uncompleted Task",
                                  style: bold25.copyWith(
                                    color: AppColor.textColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ScrollConfiguration(
                                behavior: const ScrollBehavior(),
                                child: GlowingOverscrollIndicator(
                                  axisDirection: AxisDirection.down,
                                  color: AppColor.secondaryColor.withAlpha(100),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: taskDB.taskUncompleted().length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return TaskBox(
                                        onDelete: () => deleteTask(
                                            taskDB.taskUncompleted()[index][0]),
                                        taskName:
                                            taskDB.taskUncompleted()[index][0],
                                        isComplete:
                                            taskDB.taskUncompleted()[index][1],
                                        onChanged: (value) => checkboxChange(
                                            value,
                                            taskDB.taskUncompleted()[index][0]),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Completed Task",
                                  style: bold25.copyWith(
                                    color: AppColor.textColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ScrollConfiguration(
                                behavior: const ScrollBehavior(),
                                child: GlowingOverscrollIndicator(
                                  axisDirection: AxisDirection.down,
                                  color: AppColor.secondaryColor.withAlpha(100),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: taskDB.taskCompleted().length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return TaskBoxComplete(
                                        taskName: taskDB.taskCompleted()[index]
                                            [0],
                                        isComplete:
                                            taskDB.taskCompleted()[index][1],
                                        onChanged: (value) => checkboxChange(
                                            value,
                                            taskDB.taskCompleted()[index][0]),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  )),
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.accentOrange,
          child: const Icon(Icons.add),
          onPressed: () {
            controller.clear();
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    height: deviceHeight * 0.18,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: SearchField(
                            maxLines: 2,
                            hintText: 'mencuci piring',
                            controller: controller,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 9),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            width: 2,
                                            color: AppColor.textColor),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      'Cancel',
                                      style: bold15.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.textColor),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    addData(controller.text.trim());
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 9),
                                    decoration: BoxDecoration(
                                        color: AppColor.accentOrange,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      'Add',
                                      style: bold15.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.textColor),
                                    ),
                                  )),
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
