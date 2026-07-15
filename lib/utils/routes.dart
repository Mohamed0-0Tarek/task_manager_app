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
