import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/enums.dart';
import 'package:task_manager_app/utils/routes.dart';

class EditScreen extends StatefulWidget {
  final TaskModel task;

  const EditScreen({super.key, required this.task});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleFieldController = TextEditingController();
  TextEditingController descriptionFieldController = TextEditingController();

  late DateTime selectedDate;
  late TaskModel passedTask;
  late PriorityValues selectedPriority;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    passedTask = tasks.firstWhere((task) => task.id == widget.task.id);
    selectedDate = passedTask.dateTime;
    selectedPriority = passedTask.priority;
    titleFieldController.text = passedTask.title;
    descriptionFieldController.text = passedTask.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go(AppRoutes.home);
          },
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF644BE1),
        title: Text("Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleFieldController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please fill the Title field.";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: descriptionFieldController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 20),
                Text("Priority : "),
                RadioGroup(
                  groupValue: selectedPriority,
                  onChanged: (PriorityValues? value) {
                    setState(() {
                      selectedPriority = value!;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile(
                        value: PriorityValues.low,
                        title: Text("Low"),
                      ),
                      RadioListTile(
                        value: PriorityValues.medium,
                        title: Text("Medium"),
                      ),
                      RadioListTile(
                        value: PriorityValues.high,
                        title: Text("High"),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Text("Date : "),
                    Text(selectedDate.toString().substring(0, 16)),

                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () async {
                        DateTime? pickedDateTime = await showOmniDateTimePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                        );
                        setState(() {
                          selectedDate = pickedDateTime ?? selectedDate;
                        });
                      },
                      icon: Icon(Icons.calendar_today),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          tasks[tasks.indexWhere(
                            (task) => task.id == passedTask.id,
                          )] = passedTask.copyWith(
                            title: titleFieldController.text,
                            discription: descriptionFieldController.text,
                            priority: selectedPriority,
                            dateTime: selectedDate,
                          );
                          context.go(AppRoutes.home);
                        }
                      },
                      child: Text("Done"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
