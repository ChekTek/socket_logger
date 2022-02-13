import 'dart:async';
import 'dart:developer';
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

  final _statusController = StreamController<bool>();

  Stream<bool> get status => _statusController.stream;

  connect(String socketString) async {
    try {
      if (connecting || connected) {
        return;
      }

      connecting = true;

      socketString = socketString.replaceAll('ws://', '');

      var index = socketString.lastIndexOf(':');
      if (index == -1) {
        throw ('Invalid port');
      }
      var host = socketString.substring(0, index);
      var port = int.tryParse(
              socketString.substring(index + 1, socketString.length)) ??
          -1;

      server = await HttpServer.bind(host, port);
      server.transform(WebSocketTransformer()).listen((socket) {
        socket.listen((msg) {
          logService.log(msg);
        });
      });
      _statusController.sink.add(true);
      connected = true;
      connecting = false;
    } catch (error) {
      inspect(error);
      alertService.showError('Failed to Start Server.', error.toString());
      connected = false;
      connecting = false;
      _statusController.sink.add(false);
    }
  }

  disconnect() {
    server.close();
    _statusController.sink.add(false);
    connected = false;
    connecting = false;
  }
}
