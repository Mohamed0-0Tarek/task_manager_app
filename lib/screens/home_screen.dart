import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/enums.dart';
import 'package:task_manager_app/utils/routes.dart';
import 'package:task_manager_app/widgets/analytics_bar.dart';
import 'package:task_manager_app/widgets/filter_bar.dart';
import 'package:task_manager_app/widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> filteredTasks = List.from(tasks);
  late List<TaskModel> searchedTasks = List.from(filteredTasks);
  TextEditingController searchFieldController = TextEditingController();
  PriorityValues? selectedPriority;

  void removeTask(TaskModel task) => setState(() {
    tasks.remove(task);
    searchTasks(searchFieldController.text);
  });
  void searchTasks(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        searchedTasks = List.from(filteredTasks);
      } else {
        searchedTasks = filteredTasks
            .where(
              (task) => task.title.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
      }
    });
  }

  void filterTasks(PriorityValues? priority) {
    setState(() {
      selectedPriority = priority;
      if (selectedPriority == null) {
        filteredTasks = List.from(tasks);
      } else {
        filteredTasks = tasks
            .where((task) => task.priority == selectedPriority)
            .toList();
      }
      searchTasks(searchFieldController.text);
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
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      searchFieldController.clear();
                      searchTasks(searchFieldController.text);
                    });
                  },
                  icon: Icon(Icons.backspace_outlined),
                ),

                filled: true,
                fillColor: Colors.white,
                hintText: "Search",
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
            FilterBar(
              selectedPriority: selectedPriority,
              onChange: filterTasks,
            ),
            SizedBox(height: 10),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: tasks.length,
            //     itemBuilder: (context, indx) =>
            //         TaskItem(index: indx, deleteFn: removeTask),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
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
