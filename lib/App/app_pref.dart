import 'package:shared_preferences/shared_preferences.dart';

const String userToken = "user_token";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setUserToken(String token) async {
    await _sharedPreferences.setString(userToken, token);
  }

  String? getUserToken() {
    return _sharedPreferences.getString(userToken);
  }
}
