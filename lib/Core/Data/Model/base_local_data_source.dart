import 'dart:convert';
import 'dart:developer';
import 'package:holland_bazar/App/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
/// The [BaseLocalDataSource] interface declares the basic interactions with the local data source.
///
/// All the getters and functions in this class returns a [Future] which we might NOT need in some cases
/// but we might change [SharedPreferences] package during the development period
/// and most of the local data source accessors need an async call
/// so if we change the package later, we only need to edit the local data sources
///
/// Each local data source interface must extend from this interface
///
///
abstract class BaseLocalDataSource {
  /// [BaseLocalDataSource.token] getter returns a future of String which is the user's token
  Future<String?> get token;

  Future<String?> get fcmToken;

  /// [BaseLocalDataSource.refreshToken] getter returns a future of String which is the user's refresh token
  Future<String?> get refreshToken;

  /// [BaseLocalDataSource.user] getter returns a future of UserModel which is the current system user
  Future<String?> get user;

  ///
  /// The [updateToken] function for updating the old token with the new refreshed token value
  ///
  ///
  /// @input:
  ///   - [String] user's token
  ///
  /// @returns:
  ///   [Future] of void completes after the local data source do its async work
  ///
  ///
  Future<void> updateToken(
    List<String?> tokens,
  );

  Future<void> storeFCMToken(
    String fcmToken,
  );

  Future<bool> logOutUser();

  // Future<UserModel> get personalInfo;

  Future<List<T>> getListOfObject<T>(String tableName, T Function(Map<String, dynamic> p1) fromJson);

  Future<bool> setListOfObject<T>(
    String tableName,
    List<dynamic> data,
  );

  // notificationIsOnSetter(bool val);

  // Future<bool> get notificationIsOn;
}

/// [BaseLocalDataSourceImpl] is the implementation of the [BaseLocalDataSource] interface
/// each local data source must extend this class and implement a sub-interface of [BaseLocalDataSource] interface.
class BaseLocalDataSourceImpl implements BaseLocalDataSource {
  final SharedPreferences sharedPreferences;

  BaseLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  // Returns the user's token
  @override
  Future<String?> get token => Future.value(sharedPreferences.getString(SharedPreferencesKeys.TOKEN));

  @override
  Future<String?> get fcmToken => Future.value(sharedPreferences.getString(SharedPreferencesKeys.FCM_TOKEN));

  @override
  Future<String?> get refreshToken => Future.value(sharedPreferences.getString(SharedPreferencesKeys.REFRESH_TOKEN));

//Returns the current system user
  @override
  Future<String?> get user => Future.value(sharedPreferences.getString(SharedPreferencesKeys.USER));

  @override
  Future<void> updateToken(List<String?> tokens) async {
    // print('tk ${tokens[0]}');
    // print('tk2 ${tokens[1]}');
    sharedPreferences.setString(
      SharedPreferencesKeys.TOKEN,
      tokens[0]!,
    );
    if (tokens.length == 2 && tokens[1] != null) {
      sharedPreferences.setString(SharedPreferencesKeys.REFRESH_TOKEN, tokens[1]!);
    }
  }

  @override
  Future<bool> logOutUser() async {
    await sharedPreferences.clear();
    return true;
  }

  @override
  Future<void> storeFCMToken(String fcmToken) async {
    sharedPreferences.setString(SharedPreferencesKeys.FCM_TOKEN, fcmToken);
  }

  // @override
  // Future<UserModel> get personalInfo async {
  //   return UserModel.fromJson(json
  //       .decode((sharedPreferences.getString(SharedPreferencesKeys.USER))!));
  // }

  @override
  Future<bool> setListOfObject<T>(
    String tableName,
    List<dynamic> data,
  ) async {
    List<String> dataToString = (data.map((dynamic e) => json.encode(e!.toJson())).toList());
    sharedPreferences.setStringList(tableName, dataToString);
    return true;
  }

  // @override
  // Future<bool> get notificationIsOn => Future.value(sharedPreferences.getBool(SharedPreferencesKeys.NOTIFICATION_IS_ON));

  // @override
  // notificationIsOnSetter(bool val) {
  //   sharedPreferences.setBool(SharedPreferencesKeys.NOTIFICATION_IS_ON, val);
  // }

  @override
  Future<List<T>> getListOfObject<T>(String tableName, T Function(Map<String, dynamic> p1) fromJson) async {
    final List<T> list = [];

    List<String> data = (sharedPreferences.getStringList(tableName)) ?? [];
    log("from loacal");
    log(data.toString());
    for (var element in data) {
      // if (element == null) continue;

      list.add(fromJson(json.decode(element)));
    }
    return list;
  }
}
