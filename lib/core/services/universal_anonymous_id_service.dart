import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:menu_dart_api/core/services/anonymous_id_service.dart';

// Importación condicional para web
import 'package:menu_dart_api/core/services/anonymous_id_web_service.dart'
    if (dart.library.io) 'package:menu_dart_api/core/services/anonymous_id_service.dart';

/// Servicio universal para gestionar el identificador anónimo persistente
/// Detecta automáticamente si está en web o móvil y usa el servicio apropiado
class UniversalAnonymousIdService {
  static UniversalAnonymousIdService? _instance;

  UniversalAnonymousIdService._();

  /// Singleton para obtener la instancia del servicio
  static UniversalAnonymousIdService get instance {
    _instance ??= UniversalAnonymousIdService._();
    return _instance!;
  }

  /// Obtiene o crea un ID anónimo persistente
  /// Detecta automáticamente la plataforma y usa el servicio apropiado
  Future<String> getOrCreateAnonymousId() async {
    try {
      if (kIsWeb) {
        // En web, usar localStorage
        return await AnonymousIdWebService.instance.getOrCreateAnonymousId();
      } else {
        // En móvil, usar SharedPreferences
        return await AnonymousIdService.instance.getOrCreateAnonymousId();
      }
    } catch (e) {
      developer.log('Error en getOrCreateAnonymousId universal: $e', name: 'UniversalAnonymousIdService', level: 1000);
      // Fallback: usar el servicio base que siempre está disponible
      return await AnonymousIdService.instance.getOrCreateAnonymousId();
    }
  }

  /// Regenera un nuevo ID anónimo (útil para testing o reset)
  Future<String> regenerateAnonymousId() async {
    try {
      if (kIsWeb) {
        return await AnonymousIdWebService.instance.regenerateAnonymousId();
      } else {
        return await AnonymousIdService.instance.regenerateAnonymousId();
      }
    } catch (e) {
      developer.log('Error en regenerateAnonymousId universal: $e', name: 'UniversalAnonymousIdService', level: 1000);
      return await AnonymousIdService.instance.regenerateAnonymousId();
    }
  }

  /// Limpia el ID anónimo almacenado
  Future<void> clearAnonymousId() async {
    try {
      if (kIsWeb) {
        await AnonymousIdWebService.instance.clearAnonymousId();
      } else {
        await AnonymousIdService.instance.clearAnonymousId();
      }
    } catch (e) {
      developer.log('Error en clearAnonymousId universal: $e', name: 'UniversalAnonymousIdService', level: 1000);
      await AnonymousIdService.instance.clearAnonymousId();
    }
  }

  /// Obtiene el ID anónimo actual sin generar uno nuevo
  Future<String?> getCurrentAnonymousId() async {
    try {
      if (kIsWeb) {
        return await AnonymousIdWebService.instance.getCurrentAnonymousId();
      } else {
        return await AnonymousIdService.instance.getCurrentAnonymousId();
      }
    } catch (e) {
      developer.log('Error en getCurrentAnonymousId universal: $e', name: 'UniversalAnonymousIdService', level: 1000);
      return await AnonymousIdService.instance.getCurrentAnonymousId();
    }
  }
}
