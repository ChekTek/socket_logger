import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_logger/services/log_service.dart';

final getIt = GetIt.instance;

class ClearButton extends StatelessWidget {
  const ClearButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogService logService = getIt<LogService>();

    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Container(
        margin: const EdgeInsetsDirectional.only(end: 8.0, top: 8.0),
        child: IconButton(
          onPressed: () {
            logService.clear();
          },
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          splashRadius: 18.0,
          iconSize: 22,
        ),
      ),
    );
  }
}
