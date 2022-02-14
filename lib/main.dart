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
final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

Future<void> appInit(BuildContext context) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(AlertService(navigatorKey));
  getIt.registerSingleton(Preferences(sharedPreferences));
  getIt.registerSingleton(LogService());
  getIt.registerSingleton(SocketService());
}

class MyApp extends StatelessWidget {
  var initialized = false;
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      home: initialized
          ? const Home()
          : FutureBuilder(
              future: appInit(context),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
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
