import 'dart:async';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:socket_logger/services/alert_service.dart';

import 'log_service.dart';

final getIt = GetIt.instance;

class SocketService {
  var alertService = getIt<AlertService>();
  var logService = getIt<LogService>();
  var connected = false;
  var connecting = false;
  late HttpServer server;
  List<WebSocket> openSockets = [];

  final _statusController = StreamController<bool>();

  Stream<bool> get status => _statusController.stream;

  connect(int port) async {
    try {
      if (connecting || connected) {
        return;
      }

      connecting = true;

      server = await HttpServer.bind('localhost', port);
      server.transform(WebSocketTransformer()).listen(
        (WebSocket socket) {
          logService.log('A new client has connected!');
          socket.listen((msg) {
            logService.log(msg);
          });
          openSockets.add(socket);
        },
        onDone: () {
          for (var socket in openSockets) {
            socket.close();
          }
          openSockets = [];
        },
      );
      _statusController.sink.add(true);
      connected = true;
      connecting = false;
    } catch (error) {
      alertService.showError('Failed to Start Server.', error.toString());
      connected = false;
      connecting = false;
      _statusController.sink.add(false);
    }
  }

  disconnect() {
    server.close(force: true).then((socketServer) => socketServer.close());
    _statusController.sink.add(false);
    connected = false;
    connecting = false;
  }

  send(String message) {
    for (var socket in openSockets) {
      socket.add(message);
    }
  }
}
