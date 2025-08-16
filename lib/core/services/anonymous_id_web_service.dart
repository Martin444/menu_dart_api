import 'dart:developer' as developer;
import 'dart:html' as html;

import 'package:uuid/uuid.dart';

/// Servicio para gestionar el identificador anónimo persistente en Flutter Web
/// que permite vincular órdenes en el backend sin requerir autenticación.
/// Usa localStorage del navegador para persistencia.
class AnonymousIdWebService {
  static const String _anonymousIdKey = 'anonymous_id';
  static const Uuid _uuid = Uuid();
  static AnonymousIdWebService? _instance;

  AnonymousIdWebService._();

  /// Singleton para obtener la instancia del servicio
  static AnonymousIdWebService get instance {
    _instance ??= AnonymousIdWebService._();
    return _instance!;
  }

  /// Obtiene o crea un ID anónimo persistente usando localStorage
  /// Garantiza que siempre retorna un valor no nulo
  Future<String> getOrCreateAnonymousId() async {
    try {
      String? anonymousId = html.window.localStorage[_anonymousIdKey];

      if (anonymousId == null || anonymousId.isEmpty) {
        // Generar nuevo UUID v4
        anonymousId = _uuid.v4();
        html.window.localStorage[_anonymousIdKey] = anonymousId;

        // Log solo en desarrollo para debugging
        assert(() {
          developer.log('Nuevo anonymousId generado (web): $anonymousId', name: 'AnonymousIdWebService');
          return true;
        }());
      }

      return anonymousId;
    } catch (e) {
      // En caso de error, generar un UUID temporal
      // (no persistente pero funcional)
      developer.log('Error obteniendo anonymousId de localStorage: $e', name: 'AnonymousIdWebService', level: 1000);
      return _uuid.v4();
    }
  }

  /// Regenera un nuevo ID anónimo (útil para testing o reset)
  Future<String> regenerateAnonymousId() async {
    try {
      final newId = _uuid.v4();
      html.window.localStorage[_anonymousIdKey] = newId;

      assert(() {
        developer.log('AnonymousId regenerado (web): $newId', name: 'AnonymousIdWebService');
        return true;
      }());

      return newId;
    } catch (e) {
      developer.log('Error regenerando anonymousId: $e', name: 'AnonymousIdWebService', level: 1000);
      return _uuid.v4();
    }
  }

  /// Limpia el ID anónimo almacenado
  Future<void> clearAnonymousId() async {
    try {
      html.window.localStorage.remove(_anonymousIdKey);

      assert(() {
        developer.log('AnonymousId limpiado (web)', name: 'AnonymousIdWebService');
        return true;
      }());
    } catch (e) {
      developer.log('Error limpiando anonymousId: $e', name: 'AnonymousIdWebService', level: 1000);
    }
  }

  /// Obtiene el ID anónimo actual sin generar uno nuevo
  /// Retorna null si no existe
  Future<String?> getCurrentAnonymousId() async {
    try {
      return html.window.localStorage[_anonymousIdKey];
    } catch (e) {
      developer.log('Error obteniendo anonymousId actual: $e', name: 'AnonymousIdWebService', level: 1000);
      return null;
    }
  }
}
