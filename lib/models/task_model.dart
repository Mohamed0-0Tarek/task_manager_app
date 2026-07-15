// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task_manager_app/utils/enums.dart';

class TaskModel {
  final int? id;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isCompleted;
  final PriorityValues priority;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
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
      description: discription ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
    );
  }
}

List<TaskModel> tasks = [];
