import 'dart:async';
import 'dart:io';

import 'log.dart';

class SocketService {
  var connected = false;
  var connecting = false;
  String host = 'localhost:6969';
  late ServerSocket server;
  final List<Log> logWidgets = [];

  final _controller = StreamController<String>();

  Stream<String> get logs => _controller.stream;

  connect(String socket) async {
    if (connecting || connected) {
      return;
    }

    connecting = true;

    host = socket;

    try {
      var socketInfo = host.split(':');
      server = await ServerSocket.bind(
        socketInfo[0],
        int.parse(socketInfo[1]),
      );

      server.listen((Socket client) {
        client.listen(
          (data) {
            String result = String.fromCharCodes(data);
            _controller.sink.add(result);
          },
          onError: (error) {
            client.close();
            client.destroy();
          },
          onDone: () {
            client.close();
            client.destroy();
          },
        );
      });
      connected = true;
      connecting = false;
    } catch (e) {
      print(e);
    }
  }

  disconnect() {
    server.close();
    connected = false;
    connecting = false;
  }

  clearLogs() {
    logWidgets.clear();
    _controller.sink.add('');
  }
}
