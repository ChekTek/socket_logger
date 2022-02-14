import 'dart:async';

import '../widgets/log.dart';

class LogService {
  final List<Log> _logs = [];
  final _logController = StreamController<List<Log>>();
  Stream<List<Log>> get logs => _logController.stream;

  log(String message) {
    if (message.isNotEmpty) {
      if (_logs.length >= 100) {
        _logs.removeLast();
      }
      _logs.insert(0, Log(message));
      _logController.sink.add(_logs);
    }
  }

  clear() {
    _logs.clear();
    _logController.sink.add(_logs);
  }
}
