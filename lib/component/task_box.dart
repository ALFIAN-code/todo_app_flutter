import 'package:flutter/material.dart';
import 'package:todo_app/assets/style/style.dart';

import '../pages/homepage.dart';

// ignore: must_be_immutable
class TaskBox extends StatefulWidget {
  TaskBox(
      {super.key,
      required this.taskName,
      required this.isComplete,
      required this.onChanged,
      required this.onDelete
      });

  String taskName;
  bool isComplete;
  void Function(bool?)? onChanged;
  void Function()? onDelete;

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  @override
  Widget build(BuildContext context) {
    // print('task nya adalah = ${widget.taskName}');
    // print('task nya adalah = ${widget.isComplete}');
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0,0, 15, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(children: [
                Checkbox(
                    value: widget.isComplete,
                    onChanged: widget.onChanged,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return AppColor.accentOrange;
                      }
                      return AppColor.accentOrange;
                    })),
                Text(
                  widget.taskName,
                  style: regular15.copyWith(color: AppColor.textColor),
                )
              ]),
            ),
          ),
          GestureDetector(
            onTap: widget.onDelete,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: deleteColor, borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.delete_forever, color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }
}
