import 'dart:convert';

/// Helper para convertir datos complejos a formato compatible con multipart/form-data
class MultipartHelper {
  /// Convierte un Map a JSON string si es necesario
  static String? encodeJson(Map<String, dynamic>? data) {
    if (data == null) return null;
    return jsonEncode(data);
  }

  /// Convierte una lista de strings a formato separado por comas
  static String? encodeTags(List<String>? tags) {
    if (tags == null || tags.isEmpty) return null;
    return tags.join(',');
  }

  /// Convierte un boolean a string
  static String encodeBool(bool value) {
    return value.toString();
  }

  /// Genera un nombre de archivo único basado en timestamp
  static String generateFilename({String prefix = 'file', String extension = 'jpg'}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$prefix-$timestamp.$extension';
  }
}
