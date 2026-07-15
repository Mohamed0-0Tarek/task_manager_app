import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/routes.dart';
import 'package:task_manager_app/utils/utils.dart';

class TaskItem extends StatefulWidget {
  final int index;
  final Function deleteFn;

  const TaskItem({super.key, required this.index, required this.deleteFn});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late TaskModel passedTask = tasks[widget.index];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.greenAccent, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    passedTask = passedTask.copyWith(
                      isCompleted: !passedTask.isCompleted,
                    );
                    tasks[widget.index] = passedTask;
                  });
                },
                icon: (passedTask.isCompleted)
                    ? Icon(Icons.circle_rounded)
                    : Icon(Icons.circle_outlined),
              ),
              // SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.go('${AppRoutes.task}/:${widget.index}');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        passedTask.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              priorityNameMapper[passedTask.priority]!,
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                          Text(
                            passedTask.dateTime.toString().substring(0, 16),
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.go('${AppRoutes.edit}/:${widget.index}');
                    },
                    icon: Icon(Icons.edit),
                  ),
                  // SizedBox(width: 16),
                  IconButton(
                    onPressed:()
                    {widget.deleteFn(widget.index);} ,
                    icon: Icon(Icons.delete_outline_rounded),
                  ),
                ],
              ),
              // SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
