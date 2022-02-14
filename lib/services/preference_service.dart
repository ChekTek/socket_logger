import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final SharedPreferences _sharedPreferences;

  PreferenceService(this._sharedPreferences);

  String get host {
    return _sharedPreferences.getString('host') ?? '';
  }

  void setHost(String host) {
    _sharedPreferences.setString('host', host);
  }

  bool get autoStart {
    return _sharedPreferences.getBool('auto-start') ?? false;
  }

  void setAutoStart(bool autostart) {
    _sharedPreferences.setBool('auto-start', autostart);
  }
}
