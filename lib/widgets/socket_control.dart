import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_logger/data/preferences.dart';
import 'package:socket_logger/services/socket_service.dart';

import '../services/log_service.dart';

final getIt = GetIt.instance;

class SocketControl extends StatefulWidget {
  final controller = TextEditingController(text: getIt<Preferences>().host);

  SocketControl({Key? key}) : super(key: key);

  @override
  State<SocketControl> createState() => _SocketControlState();
}

class _SocketControlState extends State<SocketControl> {
  SocketService socketService = getIt<SocketService>();
  Preferences preferenceService = getIt<Preferences>();
  LogService logService = getIt<LogService>();
  bool isChecked = getIt<Preferences>().autoStart;

  @override
  void initState() {
    super.initState();

    if (preferenceService.autoStart) {
      socketService.connect(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      preferenceService.setHost(widget.controller.value.text);
    });

    return Flex(
      direction: Axis.horizontal,
      children: [
        Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0, top: 10.0),
            child: StreamBuilder(
                stream: socketService.status,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    var status = snapshot.data as bool;
                    return status
                        ? MaterialButton(
                            child: const Text('Stop'),
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              socketService.disconnect();
                              setState(() {});
                            })
                        : MaterialButton(
                            child: const Text('Start'),
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {
                              socketService.connect(widget.controller.text);
                              setState(() {});
                            });
                  } else {
                    return MaterialButton(
                        child: const Text('Start'),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          socketService.connect(widget.controller.text);
                          setState(() {});
                        });
                  }
                })),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              controller: widget.controller,
              decoration: const InputDecoration(hintText: 'Enter socket'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    isChecked = value as bool;
                    preferenceService.setAutoStart(isChecked);
                    setState(() {});
                  }),
              const Text('AutoStart')
            ],
          ),
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(end: 8.0, top: 8.0),
          child: IconButton(
            onPressed: () {
              logService.clear();
              setState(() {});
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
