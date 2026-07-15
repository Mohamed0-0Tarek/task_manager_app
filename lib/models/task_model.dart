// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task_manager_app/utils/enums.dart';

class TaskModel {
  final int? id;
  final String title;
  final String discription;
  final DateTime dateTime;
  final bool isCompleted;
  final PriorityValues priority;

  TaskModel({
    this.id,
    required this.title,
    required this.discription,
    required this.dateTime,
    this.isCompleted = false,
    required this.priority,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? discription,
    DateTime? dateTime,
    bool? isCompleted,
    PriorityValues? priority,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      discription: discription ?? this.discription,
      dateTime: dateTime ?? this.dateTime,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
    );
  }
}

List<TaskModel> tasks = [
  TaskModel(
    id: 1,
    title: "Pray",
    discription: "pray the five important things in the life.",
    dateTime: DateTime(2026, 6, 29, 9, 30),
    priority: PriorityValues.high,
    isCompleted: true,
  ),
];
