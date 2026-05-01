import 'package:menu_dart_api/core/services/anonymous_http_client.dart';
import 'package:menu_dart_api/core/services/anonymous_dio_client.dart';

class API {
  static late API _instance;

  static bool _initialized = false;
  static String _baseURL = '';
  static String _accessToken = '';

  API._();

  static API getInstance(String urlMenuapi) {
    if (urlMenuapi.isNotEmpty) {
      _instance = API._();
      _baseURL = urlMenuapi;
      _initialized = true;
    }
    return _instance;
  }

  static String setAccessToken(String access) {
    _accessToken = access;
    return _accessToken;
  }

  static String get loginAccessToken => _accessToken;

  static String get defaulBaseUrl => _baseURL;

  bool get initialized => _initialized;

  /// Cliente HTTP con soporte para Anonymous ID automático
  static AnonymousHttpClient get httpClient => AnonymousHttpClient.instance;

  /// Cliente Dio con soporte para Anonymous ID automático
  static AnonymousDioClient get dioClient => AnonymousDioClient.instance;

  /// Obtiene el Anonymous ID actual
  static Future<String> getCurrentAnonymousId() async {
    return await httpClient.getCurrentAnonymousId();
  }

  /// Regenera el Anonymous ID (útil para testing)
  static Future<String> regenerateAnonymousId() async {
    return await httpClient.regenerateAnonymousId();
  }
}
