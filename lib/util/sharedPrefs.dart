import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPrefs? _instance;
  static SharedPreferences? _pref;

  static SharedPrefs? getInstance() {
    if (_instance == null) _instance = SharedPrefs();
    return _instance;
  }

  static init() async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
  }

  dynamic getData(String key) => _pref!.get(key);

  dynamic saveData<T>(String key, T content) {
    if (content is String) _pref!.setString(key, content);
  }

  Future<void> removeWithKey({required String key}) async => await _pref!.remove(key);
}
