import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_logger/services/socket_service.dart';

final getIt = GetIt.instance;

class ServerButton extends StatefulWidget {
  final TextEditingController serverStringController;
  const ServerButton({Key? key, required this.serverStringController})
      : super(key: key);

  @override
  State<ServerButton> createState() => _ServerButtonState();
}

class _ServerButtonState extends State<ServerButton> {
  SocketService socketService = getIt<SocketService>();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          socketService
                              .connect(widget.serverStringController.text);
                          setState(() {});
                        });
              } else {
                return MaterialButton(
                    child: const Text('Start'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      socketService.connect(widget.serverStringController.text);
                      setState(() {});
                    });
              }
            }));
  }
}
