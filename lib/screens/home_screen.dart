import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/routes.dart';
import 'package:task_manager_app/widgets/analytics_bar.dart';
import 'package:task_manager_app/widgets/filter_bar.dart';
import 'package:task_manager_app/widgets/task_item.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> searchedTasks = List.from(tasks);
  TextEditingController searchFieldController = TextEditingController();

  void removeTask(TaskModel task) => setState(() {
    tasks.remove(task);
    searchTasks(searchFieldController.text);
  });
  void searchTasks(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        searchedTasks = List.from(tasks);
      } else {
        searchedTasks = tasks
            .where(
              (task) => task.title.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF644BE1),
        title: Title(color: Colors.pink, child: Text("TaskFlow")),
        actions: [
          IconButton(
            onPressed: () {
              context.go(AppRoutes.add);
            },
            icon: Icon(Icons.add),
          ),
        ],
        actionsPadding: const EdgeInsetsDirectional.only(end: 10),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AnalyticsBar(),
            const SizedBox(height: 10),

            TextField(
              controller: searchFieldController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    width: 10,
                    color: Color.fromARGB(133, 100, 75, 225),
                  ),
                ),
              ),
              onChanged: (value) {
                searchTasks(value);
              },
            ),
            const SizedBox(height: 10),
            FilterBar(),
            SizedBox(height: 10),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: tasks.length,
            //     itemBuilder: (context, indx) =>
            //         TaskItem(index: indx, deleteFn: removeTask),
            //   ),
            // ),
            Expanded(
              child:
                  ListView.builder(
                    itemCount: searchedTasks.length,
                    itemBuilder: (context, indx) =>
                        TaskItem(task: searchedTasks[indx], deleteFn: removeTask),
                  ),
                  
            ),
          ],
        ),
      ),
    );
  }
}
