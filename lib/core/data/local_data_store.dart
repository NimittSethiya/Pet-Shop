abstract class LocalDataStore {
  Future<bool> setString(String key, String? value);
  Future<String?> getString(String key, {String? defaultValue});
}
