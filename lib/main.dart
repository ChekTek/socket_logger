import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_logger/services/alert_service.dart';
import 'package:socket_logger/data/preferences.dart';
import 'package:socket_logger/widgets/loading.dart';
import 'package:socket_logger/widgets/log_list.dart';
import 'package:socket_logger/services/log_service.dart';
import 'package:socket_logger/widgets/socket_control.dart';
import 'package:socket_logger/services/socket_service.dart';

final getIt = GetIt.instance;

void main() {
  runApp(const MyApp());
}

Future<void> appInit(BuildContext context) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(Preferences(sharedPreferences));
  getIt.registerSingleton(LogService());
  getIt.registerSingleton(AlertService(context));
  getIt.registerSingleton(SocketService());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var initialized = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light, //TODO: dark mode toggle
      home: initialized
          ? const Home()
          : FutureBuilder(
              future: appInit(context),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  initialized = true;
                  return const Home();
                } else {
                  return const Loading();
                }
              },
            ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
