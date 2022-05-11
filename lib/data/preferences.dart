import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final SharedPreferences _sharedPreferences;

  Preferences(this._sharedPreferences);

  int get host {
    return _sharedPreferences.getInt('port') ?? 8080;
  }

  void setHost(int port) {
    _sharedPreferences.setInt('port', port);
  }

  bool get autoStart {
    return _sharedPreferences.getBool('auto-start') ?? false;
  }

  void setAutoStart(bool autostart) {
    _sharedPreferences.setBool('auto-start', autostart);
  }
}
