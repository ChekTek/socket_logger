import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_logger/data/preferences.dart';
import 'package:socket_logger/services/alert_service.dart';
import 'package:socket_logger/services/log_service.dart';
import 'package:socket_logger/services/socket_service.dart';

import 'widgets/home.dart';

final getIt = GetIt.instance;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(const Size(386, 386));

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(AlertService(navigatorKey));
  getIt.registerSingleton(Preferences(sharedPreferences));
  getIt.registerSingleton(LogService());
  getIt.registerSingleton(SocketService());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      home: const Home(),
    );
  }
}
