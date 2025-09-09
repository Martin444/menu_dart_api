# OAuth de Mercado Pago - Casos de Uso

## 📚 Introducción

Esta implementación proporciona casos de uso para integrar OAuth de Mercado Pago en aplicaciones Flutter usando `menu_dart_api`. Permite a los usuarios vincular sus cuentas de Mercado Pago para procesar pagos.

## 🚀 Instalación

1. Importar la funcionalidad completa:
```dart
import 'package:menu_dart_api/by_feature/payments/oauth/mp_oauth.dart';
```

## 🔧 Uso Básico

### Opción 1: Usar el Servicio de Alto Nivel (Recomendado)

```dart
import 'package:menu_dart_api/by_feature/payments/oauth/mp_oauth.dart';

class PaymentIntegrationService {
  final MPOAuthService _mpOAuthService = MPOAuthService();

  // Verificar si hay cuenta vinculada
  Future<bool> hasLinkedAccount() async {
    return await _mpOAuthService.isAccountLinked();
  }

  // Iniciar proceso de vinculación
  Future<String?> startAccountLinking() async {
    const redirectUri = 'https://tuapp.com/oauth/callback';
    
    final result = await _mpOAuthService.initiateLinkingFlow(redirectUri);
    
    if (result.isAlreadyLinked) {
      debugPrint('Ya hay una cuenta vinculada: ${result.linkedEmail}');
      return null;
    } else if (result.hasAuthUrl) {
      debugPrint('Redirigir a: ${result.authUrl}');
      return result.authUrl;
    } else {
      debugPrint('Error: ${result.error}');
      return null;
    }
  }

  // Completar vinculación después del callback
  Future<bool> completeAccountLinking(String authCode) async {
    const redirectUri = 'https://tuapp.com/oauth/callback';
    
    try {
      final success = await _mpOAuthService.completeLinking(authCode, redirectUri);
      if (success) {
        debugPrint('¡Cuenta vinculada exitosamente!');
      }
      return success;
    } catch (e) {
      debugPrint('Error al completar vinculación: $e');
      return false;
    }
  }

  // Desvincular cuenta
  Future<bool> unlinkAccount() async {
    try {
      return await _mpOAuthService.unlinkAccount();
    } catch (e) {
      debugPrint('Error al desvincular: $e');
      return false;
    }
  }

  // Obtener información de la cuenta vinculada
  Future<String?> getAccountInfo() async {
    try {
      final status = await _mpOAuthService.getAccountStatus();
      if (status.isLinked && status.account != null) {
        return '''
Cuenta vinculada:
- Email: ${status.account!.email}
- Nickname: ${status.account!.nickname}
- País: ${status.account!.country}
- Estado: ${status.account!.status}
        ''';
      }
      return 'No hay cuenta vinculada';
    } catch (e) {
      return 'Error al obtener información: $e';
    }
  }
}
```

### Opción 2: Usar Casos de Uso Individuales

```dart
import 'package:menu_dart_api/by_feature/payments/oauth/mp_oauth.dart';

class DetailedPaymentIntegration {
  final InitiateMPOAuthUseCase _initiateUseCase = InitiateMPOAuthUseCase();
  final CompleteMPOAuthUseCase _completeUseCase = CompleteMPOAuthUseCase();
  final GetMPOAuthStatusUseCase _statusUseCase = GetMPOAuthStatusUseCase();
  final UnlinkMPAccountUseCase _unlinkUseCase = UnlinkMPAccountUseCase();
  final RefreshMPTokenUseCase _refreshUseCase = RefreshMPTokenUseCase();

  // Verificar estado detallado
  Future<void> checkDetailedStatus() async {
    try {
      final status = await _statusUseCase.execute();
      
      if (status.isLinked) {
        debugPrint('✅ Cuenta vinculada');
        debugPrint('Email: ${status.account?.email}');
        debugPrint('Collector ID: ${status.account?.collectorId}');
        debugPrint('Nickname: ${status.account?.nickname}');
      } else {
        debugPrint('❌ No hay cuenta vinculada');
      }
    } catch (e) {
      debugPrint('Error al verificar estado: $e');
    }
  }

  // Iniciar vinculación con configuración personalizada
  Future<String?> customLinking() async {
    try {
      final request = MPOAuthInitiateRequest(
        redirectUri: 'https://tuapp.com/oauth/callback',
        state: 'user_${DateTime.now().millisecondsSinceEpoch}',
      );

      final response = await _initiateUseCase.execute(request);
      debugPrint('URL de autorización: ${response.authorizationUrl}');
      debugPrint('Estado: ${response.state}');
      
      return response.authorizationUrl;
    } catch (e) {
      debugPrint('Error al iniciar OAuth: $e');
      return null;
    }
  }

  // Completar vinculación con validaciones
  Future<bool> completeWithValidation(String authCode, String redirectUri) async {
    try {
      // Validar parámetros
      if (authCode.isEmpty) {
        throw ArgumentError('Código de autorización requerido');
      }

      final request = MPOAuthCallbackRequest(
        authorizationCode: authCode,
        redirectUri: redirectUri,
      );

      final response = await _completeUseCase.execute(request);
      
      if (response.success) {
        debugPrint('✅ Vinculación completada');
        // Verificar el estado final
        await checkDetailedStatus();
        return true;
      } else {
        debugPrint('❌ Error en vinculación: ${response.message}');
        return false;
      }
    } catch (e) {
      debugPrint('Error al completar vinculación: $e');
      return false;
    }
  }

  // Mantener token actualizado
  Future<void> ensureTokenValidity() async {
    try {
      final refreshed = await _refreshUseCase.executeSilently();
      if (refreshed) {
        debugPrint('🔄 Token refrescado automáticamente');
      }
    } catch (e) {
      debugPrint('⚠️ No se pudo refrescar el token: $e');
    }
  }
}
```

## 🌐 Integración en Flutter

### Widget para Vinculación

```dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/mp_oauth.dart';

class MPAccountLinkingWidget extends StatefulWidget {
  @override
  _MPAccountLinkingWidgetState createState() => _MPAccountLinkingWidgetState();
}

class _MPAccountLinkingWidgetState extends State<MPAccountLinkingWidget> {
  final MPOAuthService _mpService = MPOAuthService();
  bool _isLinked = false;
  String? _accountEmail;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLinkingStatus();
  }

  Future<void> _checkLinkingStatus() async {
    setState(() => _isLoading = true);
    
    try {
      final isLinked = await _mpService.isAccountLinked();
      final email = await _mpService.getLinkedAccountEmail();
      
      setState(() {
        _isLinked = isLinked;
        _accountEmail = email;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al verificar estado: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _startLinking() async {
    setState(() => _isLoading = true);
    
    try {
      const redirectUri = 'https://tuapp.com/oauth/callback';
      final authUrl = await _mpService.startLinking(redirectUri);
      
      if (await canLaunch(authUrl)) {
        await launch(authUrl);
      } else {
        throw 'No se puede abrir $authUrl';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar vinculación: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _unlinkAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar desvinculación'),
        content: Text('¿Estás seguro de que quieres desvincular tu cuenta de Mercado Pago?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Desvincular'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => _isLoading = true);
      
      try {
        final success = await _mpService.unlinkAccount();
        if (success) {
          await _checkLinkingStatus();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cuenta desvinculada exitosamente')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al desvincular: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mercado Pago',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            if (_isLoading)
              CircularProgressIndicator()
            else if (_isLinked)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Cuenta vinculada'),
                    ],
                  ),
                  if (_accountEmail != null) ...[
                    SizedBox(height: 4),
                    Text(
                      'Email: $_accountEmail',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _unlinkAccount,
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text('Desvincular Cuenta'),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange),
                      SizedBox(width: 8),
                      Text('No vinculada'),
                    ],
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _startLinking,
                    child: Text('Vincular Cuenta'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
```

## 🔄 Manejo del Callback

```dart
// En tu página de callback OAuth
class OAuthCallbackPage extends StatefulWidget {
  @override
  _OAuthCallbackPageState createState() => _OAuthCallbackPageState();
}

class _OAuthCallbackPageState extends State<OAuthCallbackPage> {
  final MPOAuthService _mpService = MPOAuthService();

  @override
  void initState() {
    super.initState();
    _handleCallback();
  }

  Future<void> _handleCallback() async {
    // Obtener parámetros de la URL
    final uri = Uri.base;
    final code = uri.queryParameters['code'];
    final state = uri.queryParameters['state'];
    final error = uri.queryParameters['error'];

    if (error != null) {
      _showError('Error de autorización: $error');
      return;
    }

    if (code == null) {
      _showError('Código de autorización no recibido');
      return;
    }

    try {
      const redirectUri = 'https://tuapp.com/oauth/callback';
      final success = await _mpService.completeLinking(code, redirectUri);
      
      if (success) {
        _showSuccess('¡Cuenta vinculada exitosamente!');
        // Redirigir al dashboard o página principal
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        _showError('Error al completar la vinculación');
      }
    } catch (e) {
      _showError('Error: $e');
    }
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Procesando vinculación...'),
          ],
        ),
      ),
    );
  }
}
```

## 🛠 Manejo de Errores

```dart
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class ErrorHandler {
  static void handleMPOAuthError(dynamic error) {
    if (error is ApiException) {
      switch (error.statusCode) {
        case 400:
          debugPrint('❌ Configuración OAuth incorrecta');
          break;
        case 401:
          debugPrint('❌ Token JWT inválido');
          break;
        case 404:
          debugPrint('❌ Usuario no tiene cuenta vinculada');
          break;
        default:
          debugPrint('❌ Error de API: ${error.message}');
      }
    } else if (error is ArgumentError) {
      debugPrint('❌ Error de parámetros: ${error.message}');
    } else {
      debugPrint('❌ Error inesperado: $error');
    }
  }
}

// Uso del manejador de errores
try {
  await mpService.startLinking(redirectUri);
} catch (e) {
  ErrorHandler.handleMPOAuthError(e);
}
```

## 📝 Notas Importantes

1. **Tokens JWT**: Asegúrate de que el usuario esté autenticado antes de usar los casos de uso
2. **Redirect URI**: Debe coincidir exactamente con el configurado en Mercado Pago Developers
3. **Estado de Seguridad**: El parámetro `state` ayuda a prevenir ataques CSRF
4. **Manejo de Errores**: Siempre maneja las excepciones adecuadamente
5. **Refresh Automático**: Considera usar `ensureValidToken()` antes de operaciones críticas

## 🔗 Endpoints Backend Requeridos

Estos casos de uso requieren que el backend tenga implementados los siguientes endpoints:

- `POST /payments/oauth/initiate`
- `POST /payments/oauth/callback`
- `GET /payments/oauth/status`
- `POST /payments/oauth/unlink`
- `POST /payments/oauth/refresh-token`

Consulta la documentación del backend para más detalles sobre la implementación de estos endpoints.
