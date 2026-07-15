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
