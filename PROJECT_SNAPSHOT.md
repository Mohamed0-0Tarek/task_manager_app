# Project Source Snapshot

This snapshot contains the actual source code for the Flutter app library files and the package manifest.

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
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
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

    # An image asset can refer to one or more resolution-specific "variants", see
    # https://flutter.dev/to/resolution-aware-images

    # For details regarding adding assets from package dependencies, see
    # https://flutter.dev/to/asset-from-package

    # To add custom fonts to your application, add a fonts section here,
    # in this "flutter" section. Each entry in this list should have a
    # "family" key with the font family name, and a "fonts" key with a
    # list giving the asset and other descriptors for the font. For
    # example:
    # fonts:
    #   - family: Schyler
    #     fonts:
    #       - asset: fonts/Schyler-Regular.ttf
    #       - asset: fonts/Schyler-Italic.ttf
    #         style: italic
    #   - family: Trajan Pro
    #     fonts:
    #       - asset: fonts/TrajanPro.ttf
    #       - asset: fonts/TrajanPro_Bold.ttf
    #         weight: 700
    #
    # For details regarding fonts from package dependencies,
    # see https://flutter.dev/to/font-from-package
```

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

## lib/models/task_model.dart

```dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task_manager_app/utils/enums.dart';

class TaskModel {
  final int id;
  final String title;
  final String discription;
  final DateTime dateTime;
  final bool isCompleted;
  final PriorityValues priority;

  TaskModel({
    required this.id,
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
```

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
  State<AddScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<AddScreen> {
  // late int? indx = widget.index;

  // late TaskModel passedTask = tasks[widget.index];
  // late DateTime selectedDate = passedTask.dateTime;
  // late PriorityValues? selectedPriority = passedTask.priority;
  TextEditingController titleFieldController = TextEditingController();
  TextEditingController descriptionFieldController = TextEditingController();

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
                // groupValue: selectedPriority,
                onChanged: (PriorityValues? value) {
                  setState(() {
                    // selectedPriority = value;
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
                  Text(
                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  ),
                  SizedBox(width: 10),
                  // IconButton(
                  // onPressed: () async {
                  // DateTime? pickedDateTime = await showOmniDateTimePicker(
                  // context: context,
                  // initialDate: selectedDate,
                  // );
                  // },
                  // icon: Icon(Icons.calendar_today),
                  // ),
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

## lib/screens/edit_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/enums.dart';
import 'package:task_manager_app/utils/routes.dart';

class EditScreen extends StatefulWidget {
  final int index;

  const EditScreen({super.key, required this.index});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  // late int? indx = widget.index;

  late TaskModel passedTask = tasks[widget.index];
  late DateTime selectedDate = passedTask.dateTime;
  late PriorityValues? selectedPriority = passedTask.priority;
  TextEditingController titleFieldController = TextEditingController();
  TextEditingController descriptionFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go(AppRoutes.home);
          },
        ),
        title: Text("Edit Task"),
        actions: [
          FilledButton(
            onPressed: () {
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
                    selectedPriority = value;
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
                  Text(
                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      DateTime? pickedDateTime = await showOmniDateTimePicker(
                        context: context,
                        initialDate: selectedDate,
                      );
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
```

## lib/screens/home_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/task_model.dart';
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
  void removeTask(int index) => setState(() {
    tasks.removeAt(index);
  });

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
            const TextField(
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
            ),
            const SizedBox(height: 10),
            FilterBar(),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, indx) =>
                    TaskItem(index: indx, deleteFn: removeTask),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

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

## lib/screens/task_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/routes.dart';
import 'package:task_manager_app/utils/utils.dart';

class TaskScreen extends StatefulWidget {
  final int index;
  const TaskScreen({super.key, required this.index});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  
  late TaskModel passedTask = tasks[widget.index];

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
                Text("${priorityNameMapper[passedTask.priority]}", style: TextStyle(fontWeight: FontWeight.w300)),
              ],
            ),
            SizedBox(height: 10),
            Text(
              passedTask.discription,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
```

## lib/utils/enums.dart

```dart
enum PriorityValues { high, medium, low }
```

## lib/utils/routes.dart

```dart
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/screens/add_screen.dart';
import 'package:task_manager_app/screens/edit_screen.dart';
import 'package:task_manager_app/screens/home_screen.dart';
import 'package:task_manager_app/screens/splash_screen.dart';
import 'package:task_manager_app/screens/task_screen.dart';

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
      path: '${AppRoutes.task}/:index',
      builder: (context, state) {
        int indx = int.parse(state.pathParameters["index"]!.substring(1));
        return TaskScreen(index: indx);
      },
    ),
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '${AppRoutes.edit}/:index',
      builder: (context, state) {
        int indx = int.parse(state.pathParameters["index"]!.substring(1));
        return EditScreen(index: indx);
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

## lib/utils/utils.dart

```dart
import 'package:task_manager_app/utils/enums.dart';



Map<PriorityValues, String> priorityNameMapper = {
  PriorityValues.low: "Low",
  PriorityValues.medium: "Medium",
  PriorityValues.high: "High",
};
```

## lib/widgets/analytics_bar.dart

```dart
import 'package:flutter/material.dart';

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
                      "Done : 5",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment(0, 0),
                    child: Text(
                      "Remains : 5",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "10",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight(20),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      //Analytics Bar
    );
  }
}
```

## lib/widgets/filter_bar.dart

```dart
import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

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
            Container(
              decoration: BoxDecoration(
                color: Colors.amberAccent,
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
                child: Text("all"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
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
                child: Text("high"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
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
                child: Text("medium"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
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
                child: Text("low"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## lib/widgets/task_item.dart

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/utils/routes.dart';
import 'package:task_manager_app/utils/utils.dart';

class TaskItem extends StatefulWidget {
  final int index;
  final void deleteFn;

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
                    onPressed:widget.deleteFn ,
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
```
