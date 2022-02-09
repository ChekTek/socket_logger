import 'dart:async';
import 'dart:io';

import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
// import 'package:web_socket_channel/web_socket_channel.dart';

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

    var handler = webSocketHandler((webSocket) {
      // add this type in a PR for this library...
      // (webSocket as WebSocketChannel)
      print(webSocket);
      webSocket.stream.listen((message) {
        _controller.sink.add(message);
        print(message);
      });
    });

    shelf_io.serve(handler, 'localhost', 6969).then((server) {
      print('Serving at ws://${server.address.host}:${server.port}');
    });

    // runZoned(() async {
    //   var server = await HttpServer.bind('127.0.0.1', 6969);
    //   server.listen((HttpRequest req) async {
    //     if (req.uri.path == '/ws') {
    //       var socket = await WebSocketTransformer.upgrade(req);
    //       socket.listen(print);
    //     }
    //   });
    // }, onError: (e) => print("An error occurred."));

    // try {
    //   var socketInfo = host.split(':');
    //   server = await ServerSocket.bind(
    //     socketInfo[0],
    //     int.parse(socketInfo[1]),
    //   );

    //   server.listen((Socket client) {
    //     client.listen(
    //       (data) {
    //         String result = String.fromCharCodes(data);
    //         _controller.sink.add(result);
    //       },
    //       onError: (error) {
    //         client.close();
    //         client.destroy();
    //       },
    //       onDone: () {
    //         client.close();
    //         client.destroy();
    //       },
    //     );
    //   });
    //   connected = true;
    //   connecting = false;
    // } catch (e) {
    //   print(e);
    // }
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
