import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/routes.dart';
import 'package:task_manager_app/utils/utils.dart';

class TaskScreen extends StatefulWidget {
  final TaskModel task;
  const TaskScreen({super.key, required this.task});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TaskModel passedTask = widget.task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go(AppRoutes.home);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              passedTask.title,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  passedTask.dateTime.toString(),
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  "${priorityNameMapper[passedTask.priority]}",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(passedTask.description, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
