# Task Manager App — AI Project Context Snapshot

This file contains the current Flutter project's Dart source files under `lib/` plus the `pubspec.yaml` file content so you can provide it to an AI coding assistant for analysis, debugging, or refactoring.

---

## pubspec.yaml

```yaml
name: task_manager_app
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: "none" # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
    sdk: ^3.12.1

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
    flutter:
        sdk: flutter

    # The following adds the Cupertino Icons font to your application.
    # Use with the CupertinoIcons class for iOS style icons.
    cupertino_icons: ^1.0.8
    omni_datetime_picker: ^2.3.2
    go_router: ^17.3.0

    custom_radio_grouped_button: ^2.3.0

dev_dependencies:
    flutter_test:
        sdk: flutter

    # The "flutter_lints" package below contains a set of recommended lints to
    # encourage good coding practices. The lint set provided by the package is
    # activated in the `analysis_options.yaml` file located at the root of your
    # package. See that file for information about deactivating specific lint
    # rules and activating additional ones.
    flutter_lints: ^6.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:
    # The following line ensures that the Material Icons font is
    # included with your application, so that you can use the icons in
    # the material Icons class.
    uses-material-design: true

    # To add assets to your application, add an assets section, like this:
    assets:
        - assets/images/logo.jpg
```

---

## lib/main.dart

```dart
import 'package:flutter/material.dart';
import 'package:task_manager_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: router,
    );
  }
}
```

---

## lib/models/task_model.dart

```dart
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
```

---

## lib/screens/add_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/enums.dart';
import 'package:task_manager_app/utils/routes.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleFieldController = TextEditingController();
  TextEditingController descriptionFieldController = TextEditingController();
  late DateTime selectedDate;
  late PriorityValues selectedPriority;
  final formKey = GlobalKey<FormState>();

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
                          tasks.add(
                            TaskModel(
                              id: DateTime.now().millisecondsSinceEpoch,
                              title: titleFieldController.text,
                              description: descriptionFieldController.text,
                              priority: selectedPriority,
                              dateTime: selectedDate,
                            ),
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
```

---

## lib/screens/edit_screen.dart

```dart
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
```

---

## lib/screens/home_screen.dart

```dart
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

  void toggleTasks (){
    setState(() {

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
            Expanded(
              child: ListView.builder(
                itemCount: searchedTasks.length,
                itemBuilder: (context, indx) =>
                    TaskItem(task: searchedTasks[indx], deleteFn: removeTask,toggleTask: toggleTasks,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## lib/screens/splash_screen.dart

```dart
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset("assets/images/logo.jpg")));
  }
}
```

---

## lib/screens/task_screen.dart

```dart
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
```

---

## lib/utils/enums.dart

```dart
enum PriorityValues { high, medium, low }
```

---

## lib/utils/routes.dart

```dart
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/screens/add_screen.dart';
import 'package:task_manager_app/screens/edit_screen.dart';
import 'package:task_manager_app/screens/home_screen.dart';
import 'package:task_manager_app/screens/splash_screen.dart';
import 'package:task_manager_app/screens/task_screen.dart';
import 'package:task_manager_app/models/task_model.dart';

class AppRoutes {
  static const String home = '/';
  static const String task = '/task';
  static const String splash = '/splash';
  static const String edit = '/edit';
  static const String add = '/add';
}

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(path: AppRoutes.home, builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '${AppRoutes.task}/:id',
      builder: (context, state) {
        int id = int.parse(state.pathParameters["id"]!);
        return TaskScreen(task: tasks.firstWhere((task) => task.id == id));
      },
    ),
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '${AppRoutes.edit}/:id',
      builder: (context, state) {
        int id = int.parse(state.pathParameters["id"]!);
        return EditScreen(task: tasks.firstWhere((task) => task.id == id));
      },
    ),
    GoRoute(
      path: AppRoutes.add,
      builder: (context, state) {
        return AddScreen();
      },
    ),
  ],
);
```

---

## lib/utils/utils.dart

```dart
import 'package:task_manager_app/utils/enums.dart';

Map<PriorityValues, String> priorityNameMapper = {
  PriorityValues.low: "Low",
  PriorityValues.medium: "Medium",
  PriorityValues.high: "High",
};
```

---

## lib/widgets/analytics_bar.dart

```dart
import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task_model.dart';

class AnalyticsBar extends StatelessWidget {
  const AnalyticsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 5, color: Color.fromARGB(133, 100, 75, 225)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment(0, 0),

                    child: Text(
                      "Done : ${tasks.where((task) => task.isCompleted).length}",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment(0, 0),
                    child: Text(
                      "Remains : ${tasks.where((task) => !task.isCompleted).length}",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "${tasks.length}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight(20),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## lib/widgets/filter_bar.dart

```dart
import 'package:flutter/material.dart';
import 'package:task_manager_app/utils/enums.dart';

class FilterBar extends StatefulWidget {
  final PriorityValues? selectedPriority;
  final Function (PriorityValues?)onChange;
  const FilterBar({
    super.key,
    required this.selectedPriority,
    required this.onChange,
  });

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  Widget filterRadioButton(PriorityValues? priority, String text) {
    return InkWell(
      onTap: () {
        widget.onChange(priority);
      },
      child: Container(
        decoration: BoxDecoration(
          color: (widget.selectedPriority == priority)
              ? Colors.amberAccent
              : Colors.transparent,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsetsGeometry.directional(
            start: 20,
            end: 20,
            top: 8,
            bottom: 8,
          ),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 5, color: Color.fromARGB(133, 100, 75, 225)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterRadioButton(null, "All"),
            filterRadioButton(PriorityValues.high, "High"),
            filterRadioButton(PriorityValues.medium, "Medium"),
            filterRadioButton(PriorityValues.low, "Low"),
          ],
        ),
      ),
    );
  }
}
```

---

## lib/widgets/task_item.dart

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/routes.dart';
import 'package:task_manager_app/utils/utils.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;
  final Function deleteFn;
  final Function toggleTask;

  const TaskItem({
    super.key,
    required this.task,
    required this.deleteFn,
    required this.toggleTask,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late TaskModel passedTask = widget.task;

  @override
  void didUpdateWidget(covariant TaskItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.task.id != widget.task.id) {
      passedTask = widget.task;
    }
  }

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
                    tasks[tasks.indexWhere(
                          (task) => task.id == passedTask.id,
                        )] =
                        passedTask;
                  });
                  widget.toggleTask();
                },
                icon: (passedTask.isCompleted)
                    ? Icon(Icons.circle_rounded)
                    : Icon(Icons.circle_outlined),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.go('${AppRoutes.task}/${widget.task.id}');
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
                      context.go('${AppRoutes.edit}/${widget.task.id}');
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.deleteFn(passedTask);
                    },
                    icon: Icon(Icons.delete_outline_rounded),
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
```
