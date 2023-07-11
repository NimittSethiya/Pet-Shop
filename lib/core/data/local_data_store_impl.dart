import 'package:shared_preferences/shared_preferences.dart';
import 'local_data_store.dart';

class LocalDataStoreImpl extends LocalDataStore {
  LocalDataStoreImpl();

  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<String?> getString(String key, {String? defaultValue}) {
    return _getValue<String>(key, defaultValue, (pref) => pref.getString(key)!);
  }

  @override
  Future<bool> setString(String key, String? value) {
    return _setValue((pref) {
      if (value == null) {
        return pref.remove(key);
      } else {
        return pref.setString(key, value);
      }
    });
  }

  Future<T?> _getValue<T>(
      String key, T? defaultValue, T Function(SharedPreferences) function) {
    return prefs.then((pref) {
      if (pref.containsKey(key)) {
        return function(pref);
      } else {
        return defaultValue;
      }
    });
  }

  Future<bool> _setValue<T>(Future<bool> Function(SharedPreferences) function) {
    return prefs.then((pref) {
      return function(pref);
    });
  }
}
