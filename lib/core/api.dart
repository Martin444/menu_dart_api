class API {
  static late API _instance;

  static bool _inicialized = false;
  static String _baseURL = '';
  static String _accessToken = '';

  API._();

  static API getInstance(String urlMenuapi) {
    if (urlMenuapi.isNotEmpty) {
      _instance = API._();
      _baseURL = urlMenuapi;
      _inicialized = true;
    }
    return _instance;
  }

  static String setAccessToken(String access) {
    _accessToken = access;
    return _accessToken;
  }

  static String get defaulBaseUrl => _baseURL;
  static String get loginAccessToken => _accessToken;

  bool get initialized => _inicialized;
}
