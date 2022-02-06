import 'dart:async';
import 'dart:io';

class SocketService {
  String host = 'localhost:6969';
  List<String> logList = [];

  final _controller = StreamController<String>();

  Stream<String> get logs => _controller.stream;

  updateSocketConnection(String socket) async {
    host = socket;

    try {
      var socketInfo = host.split(':');
      var server =
          await ServerSocket.bind(socketInfo[0], int.parse(socketInfo[1]));

      server.listen((Socket client) {
        client.listen(
          (List<int> data) {
            String result = String.fromCharCodes(data);
            print(result);
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
    } catch (e) {
      print(e);
    }
  }
}
