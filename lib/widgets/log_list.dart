import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'log.dart';
import '../services/log_service.dart';

final getIt = GetIt.instance;

class LogList extends StatelessWidget {
  const LogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logService = getIt<LogService>();

    return StreamBuilder(
        stream: logService.logs,
        builder: (BuildContext context, AsyncSnapshot<List<Log>> snapshot) {
          if (snapshot.hasData) {
            var logList = snapshot.data as List<Log>;
            return Flexible(
                child: ListView.builder(
                    itemCount: logList.length,
                    itemBuilder: (context, index) {
                      return logList.elementAt(index);
                    }));
          }

          return Flexible(child: ListView());
        });
  }
}
