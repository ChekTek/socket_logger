import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'log.dart';
import 'socket_service.dart';

final getIt = GetIt.instance;

class LogList extends StatelessWidget {
  LogList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = getIt<SocketService>();

    return StreamBuilder(
        stream: service.logs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var messages = (snapshot.data as String).split('\n');

            messages.forEach((message) {
              if (message.trim() != '') {
                service.logWidgets.insert(0, Log(message));
              }
            });

            return Flexible(
                child: ListView.builder(
                    itemCount: service.logWidgets.length,
                    itemBuilder: (context, index) {
                      return service.logWidgets[index];
                    }));
          }

          return Flexible(child: ListView());
        });
  }
}
