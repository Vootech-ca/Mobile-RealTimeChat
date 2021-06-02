import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vootech_realchat/src/models/acces_token_Result_model.dart';

class LocalStorageService {
  static const String CurrentUserData = "current_user";
  static const String OnBoardScreenSeen = 'onboard_seen';

  static LocalStorageService _instance;

  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  AccessTokenResult get currentUser {
    String dataString = _getFromDisk(CurrentUserData);
    try {
      return AccessTokenResult.fromJson(json.decode(dataString));
    } catch (e) {
      return null;
    }
  }

  set currentUser(AccessTokenResult user) {
    if (user == null) {
      _saveToDisk(CurrentUserData, "");
    } else {
      var dataJson = json.encode(user.toJson());
      _saveToDisk(CurrentUserData, dataJson);
    }
  }

  bool get onBoardScreenSeen {
    return _getFromDisk(OnBoardScreenSeen) ?? false;
  }

  set onBoardScreenSeen(bool value) {
    _saveToDisk(OnBoardScreenSeen, value);
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
