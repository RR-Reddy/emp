import 'package:emp/pages/home/bloc/emp_list_cubit.dart';
import 'package:emp/models/employee.dart';
import 'package:emp/pages/index.dart';
import 'package:emp/service/storage_service.dart';
import 'package:emp/theme/themes_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final service = StorageService(prefs);
  runApp(MyApp(service: service));
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.service,
  });

  final StorageService service;
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmpListCubit(
        service: service,
        scaffoldMessengerKey: _scaffoldMessengerKey,
      ),
      child: MaterialApp(
        title: 'Employee information',
        theme: ThemesUtils.getThemeData(),
        onGenerateRoute: _generateRoute,
        scaffoldMessengerKey: _scaffoldMessengerKey,
      ),
    );
  }
}

Route _generateRoute(RouteSettings settings) {
  Widget? routeWidget;
  switch (settings.name) {
    case HomePage.routeName:
      routeWidget = const HomePage();
      break;
    case AddEditPage.routeName:
      routeWidget = AddEditPage(
        employee: settings.arguments as Employee?,
      );
      break;
  }

  return MaterialPageRoute(
    builder: (_) => routeWidget ?? const SizedBox.shrink(),
  );
}
