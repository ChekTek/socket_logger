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
    var connectButton = MaterialButton(
        child: const Text('Start'),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          socketService.connect(widget.serverStringController.text);
          setState(() {});
        });

    var disconnectButton = MaterialButton(
        child: const Text('Stop'),
        color: Theme.of(context).errorColor,
        onPressed: () {
          socketService.disconnect();
          setState(() {});
        });

    return Padding(
        padding: const EdgeInsetsDirectional.only(start: 14.0, top: 12.0),
        child: StreamBuilder(
            stream: socketService.status,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                var status = snapshot.data as bool;
                return status ? disconnectButton : connectButton;
              } else {
                return connectButton;
              }
            }));
  }
}
