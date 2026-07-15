import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/enums.dart';
import 'package:task_manager_app/utils/routes.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<AddScreen> {
  TextEditingController titleFieldController = TextEditingController();
  TextEditingController descriptionFieldController = TextEditingController();
  late DateTime selectedDate;
  late PriorityValues selectedPriority;

  @override
  void initState() {
    selectedDate = DateTime.now();
    selectedPriority = PriorityValues.medium;

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
        title: Text("Add Task"),
        actions: [
          FilledButton(
            onPressed: () {
              tasks.add(
                TaskModel(
                  title: titleFieldController.text,
                  discription: descriptionFieldController.text,
                  priority: selectedPriority,
                  dateTime: selectedDate,
                ),
              );
              context.go(AppRoutes.home);
            },
            child: Text("Done"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleFieldController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
