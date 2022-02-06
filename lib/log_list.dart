import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'log.dart';
import 'socket_service.dart';

final getIt = GetIt.instance;

class LogList extends StatelessWidget {
  final List<Log> logWidgets = [];

  LogList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getIt<SocketService>().logs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            logWidgets.insert(0, Log(snapshot.data as String));
            return Flexible(
                child: ListView.builder(
                    itemCount: logWidgets.length,
                    itemBuilder: (context, index) {
                      return logWidgets[index];
                    }));
          }

          return Flexible(child: ListView());
        });
  }
}
