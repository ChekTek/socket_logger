import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_logger/services/socket_service.dart';

import '../services/log_service.dart';

final getIt = GetIt.instance;

class SocketControl extends StatefulWidget {
  final TextEditingController c = TextEditingController(text: 'localhost:6969');

  SocketControl({Key? key}) : super(key: key);

  @override
  State<SocketControl> createState() => _SocketControlState();
}

class _SocketControlState extends State<SocketControl> {
  @override
  Widget build(BuildContext context) {
    var socketService = getIt<SocketService>();
    var logService = getIt<LogService>();

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
                              socketService.connect(widget.c.text);
                              setState(() {});
                            });
                  } else {
                    return MaterialButton(
                        child: const Text('Start'),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          socketService.connect(widget.c.text);
                          setState(() {});
                        });
                  }
                })),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              controller: widget.c,
              decoration: const InputDecoration(
                hintText: 'Enter socket',
              ),
            ),
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
