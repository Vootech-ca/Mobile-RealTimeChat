import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String AccessToken = "access_token";
  static const String RefreshToken = "refresh_token";
  static const String CurrentUserData = "current_user";
  static const String AppLanguageKey = 'current_language';
  static const String FirebaseInstanceId = "fcm_token";
  static const String NotificationsCount = "notifications_count";
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

  // Access Token
  String get accessToken => _getFromDisk(AccessToken);

  set accessToken(String value) => _saveToDisk(AccessToken, value);

  // Refresh Token
  String get refreshToken => _getFromDisk(RefreshToken);

  set refreshToken(String value) => _saveToDisk(RefreshToken, value);

  // Language Code


  // Fcm Token


  // Notifications


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
