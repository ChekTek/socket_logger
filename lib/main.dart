import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_logger/services/alert_service.dart';
import 'package:socket_logger/services/preference_service.dart';
import 'package:socket_logger/widgets/log_list.dart';
import 'package:socket_logger/services/log_service.dart';
import 'package:socket_logger/widgets/socket_control.dart';
import 'package:socket_logger/services/socket_service.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(PreferenceService(preferences));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!getIt.isRegistered<AlertService>()) {
      getIt.registerSingleton(LogService());
      getIt.registerSingleton(AlertService(context));
      getIt.registerSingleton(SocketService());
    }

    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SocketControl(),
          ),
        ),
        const LogList(),
      ],
    ));
  }
}
