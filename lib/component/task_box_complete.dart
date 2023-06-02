import 'package:flutter/material.dart';
import 'package:todo_app/assets/style/style.dart';

// ignore: must_be_immutable
class TaskBoxComplete extends StatefulWidget {
  TaskBoxComplete(
      {super.key,
      required this.taskName,
      required this.isComplete,
      required this.onChanged});

  String taskName;
  bool isComplete;
  void Function(bool?)? onChanged;

  @override
  State<TaskBoxComplete> createState() => _TaskBoxCompleteState();
}

class _TaskBoxCompleteState extends State<TaskBoxComplete> {
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.accentGreen,
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
                  style: regular15.copyWith(color: Colors.white),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
