class API {
  static late API _instance;

  static bool _inicialized = false;
  static String _baseURL = '';

  API._();

  static API getInstance(String urlMenuapi) {
    if (urlMenuapi.isNotEmpty) {
      _instance = API._();
      _baseURL = urlMenuapi;
      _inicialized = true;
    }
    return _instance;
  }

  static String get defaulBaseUrl => _baseURL;

  bool get initialized => _inicialized;
}
