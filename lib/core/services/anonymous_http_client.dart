import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/services/universal_anonymous_id_service.dart';

/// Cliente HTTP que automáticamente agrega el header X-Anonymous-Id
/// a todas las peticiones para trackear usuarios anónimos
class AnonymousHttpClient {
  static const String _anonymousIdHeader = 'X-Anonymous-Id';
  static AnonymousHttpClient? _instance;
  final http.Client _httpClient;
  final UniversalAnonymousIdService _anonymousIdService;

  AnonymousHttpClient._()
      : _httpClient = http.Client(),
        _anonymousIdService = UniversalAnonymousIdService.instance;

  /// Singleton para obtener la instancia del cliente
  static AnonymousHttpClient get instance {
    _instance ??= AnonymousHttpClient._();
    return _instance!;
  }

  /// Agrega el header X-Anonymous-Id a los headers existentes
  Future<Map<String, String>> _addAnonymousIdHeader(Map<String, String>? headers) async {
    final anonymousId = await _anonymousIdService.getOrCreateAnonymousId();
    final headersWithAnonymousId = Map<String, String>.from(headers ?? {});
    headersWithAnonymousId[_anonymousIdHeader] = anonymousId;

    // Log solo en debug
    assert(() {
      developer.log('Agregando header $_anonymousIdHeader: $anonymousId', name: 'AnonymousHttpClient');
      return true;
    }());

    return headersWithAnonymousId;
  }

  /// GET request con anonymous ID automático
  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    final headersWithAnonymousId = await _addAnonymousIdHeader(headers);
    return _httpClient.get(url, headers: headersWithAnonymousId);
  }

  /// POST request con anonymous ID automático
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final headersWithAnonymousId = await _addAnonymousIdHeader(headers);
    return _httpClient.post(
      url,
      headers: headersWithAnonymousId,
      body: body,
      encoding: encoding,
    );
  }

  /// PUT request con anonymous ID automático
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final headersWithAnonymousId = await _addAnonymousIdHeader(headers);
    return _httpClient.put(
      url,
      headers: headersWithAnonymousId,
      body: body,
      encoding: encoding,
    );
  }

  /// DELETE request con anonymous ID automático
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final headersWithAnonymousId = await _addAnonymousIdHeader(headers);
    return _httpClient.delete(
      url,
      headers: headersWithAnonymousId,
      body: body,
      encoding: encoding,
    );
  }

  /// PATCH request con anonymous ID automático
  Future<http.Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final headersWithAnonymousId = await _addAnonymousIdHeader(headers);
    return _httpClient.patch(
      url,
      headers: headersWithAnonymousId,
      body: body,
      encoding: encoding,
    );
  }

  /// HEAD request con anonymous ID automático
  Future<http.Response> head(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    final headersWithAnonymousId = await _addAnonymousIdHeader(headers);
    return _httpClient.head(url, headers: headersWithAnonymousId);
  }

  /// Cierra el cliente HTTP
  void close() {
    _httpClient.close();
  }

  /// Obtiene el anonymous ID actual sin hacer una petición
  Future<String> getCurrentAnonymousId() async {
    return await _anonymousIdService.getOrCreateAnonymousId();
  }

  /// Regenera el anonymous ID (útil para testing)
  Future<String> regenerateAnonymousId() async {
    return await _anonymousIdService.regenerateAnonymousId();
  }
}
