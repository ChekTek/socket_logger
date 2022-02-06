import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_logger/log_list.dart';
import 'package:socket_logger/socket_service.dart';

final getIt = GetIt.instance;
void main() {
  getIt.registerSingleton(SocketService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final c = TextEditingController(text: getIt<SocketService>().host);

    return MaterialApp(
      title: 'Socket Logger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Socket Logger'),
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
                child: TextField(
                  controller: c,
                  decoration: InputDecoration(
                    hintText: 'Enter socket',
                    suffix: MaterialButton(
                        child: const Text('Connect'),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          getIt<SocketService>().updateSocketConnection(c.text);
                        }),
                  ),
                ),
              ),
              LogList(),
            ],
          )),
    );
  }
}
