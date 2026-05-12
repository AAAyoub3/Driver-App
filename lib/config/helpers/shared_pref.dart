import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPrefHelper {
  final SharedPreferences sharedPreferences;

  SharedPrefHelper(this.sharedPreferences);

  Future<bool> saveInt({
    required String key,
    required int value,
  }) {
    return sharedPreferences.setInt(key, value);
  }

  Future<bool> saveDouble({
    required String key,
    required double value,
  }) {
    return sharedPreferences.setDouble(key, value);
  }

  Future<bool> saveString({
    required String key,
    required String value,
  }) {
    return sharedPreferences.setString(key, value);
  }

  Future<bool> saveBool({
    required String key,
    required bool value,
  }) {
    return sharedPreferences.setBool(key, value);
  }

  int? getInt(String key) {
    return sharedPreferences.getInt(key);
  }

  double? getDouble(String key) {
    return sharedPreferences.getDouble(key);
  }

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }

  Future<bool> removeData(String key) {
    return sharedPreferences.remove(key);
  }
}
// @module
// class SharedPrefHelper {
//   @lazySingleton
//   Future<SharedPreferences> get sharedPreferences =>
//       SharedPreferences.getInstance();
// }
