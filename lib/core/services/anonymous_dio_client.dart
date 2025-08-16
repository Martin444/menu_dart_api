import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:menu_dart_api/core/services/universal_anonymous_id_service.dart';

/// Interceptor de Dio que automáticamente agrega el header X-Anonymous-Id
/// a todas las peticiones para trackear usuarios anónimos
class AnonymousIdInterceptor extends Interceptor {
  static const String _anonymousIdHeader = 'X-Anonymous-Id';
  final UniversalAnonymousIdService _anonymousIdService;

  AnonymousIdInterceptor() : _anonymousIdService = UniversalAnonymousIdService.instance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final anonymousId = await _anonymousIdService.getOrCreateAnonymousId();
      options.headers[_anonymousIdHeader] = anonymousId;

      // Log solo en debug
      assert(() {
        developer.log('Agregando header $_anonymousIdHeader: $anonymousId a ${options.uri}',
            name: 'AnonymousIdInterceptor');
        return true;
      }());
    } catch (e) {
      developer.log('Error agregando anonymousId header: $e', name: 'AnonymousIdInterceptor', level: 1000);
    }

    handler.next(options);
  }
}

/// Cliente Dio configurado con interceptor de Anonymous ID
class AnonymousDioClient {
  static AnonymousDioClient? _instance;
  late final Dio _dio;

  AnonymousDioClient._() {
    _dio = Dio();
    _dio.interceptors.add(AnonymousIdInterceptor());
  }

  /// Singleton para obtener la instancia del cliente
  static AnonymousDioClient get instance {
    _instance ??= AnonymousDioClient._();
    return _instance!;
  }

  /// Acceso directo al cliente Dio
  Dio get dio => _dio;

  /// Obtiene el anonymous ID actual
  Future<String> getCurrentAnonymousId() async {
    return await UniversalAnonymousIdService.instance.getOrCreateAnonymousId();
  }

  /// Regenera el anonymous ID (útil para testing)
  Future<String> regenerateAnonymousId() async {
    return await UniversalAnonymousIdService.instance.regenerateAnonymousId();
  }
}
