# 🔗 OAuth de Mercado Pago para menu_dart_api

## 📋 Descripción

Esta implementación proporciona casos de uso completos para integrar OAuth de Mercado Pago en aplicaciones Flutter usando `menu_dart_api`. Permite a los usuarios vincular sus cuentas de Mercado Pago para procesar pagos directamente desde la aplicación.

## 🏗️ Arquitectura

```
lib/by_feature/payments/oauth/
├── data/
│   ├── provider/
│   │   └── mp_oauth_provider.dart          # Implementación HTTP
│   ├── repository/
│   │   └── mp_oauth_repository.dart        # Interfaz abstracta
│   └── usescase/
│       ├── initiate_mp_oauth_usecase.dart  # Iniciar OAuth
│       ├── complete_mp_oauth_usecase.dart  # Completar OAuth
│       ├── get_mp_oauth_status_usecase.dart # Estado de vinculación
│       ├── unlink_mp_account_usecase.dart  # Desvincular cuenta
│       ├── refresh_mp_token_usecase.dart   # Refrescar token
│       └── mp_oauth_usecases.dart          # Export barrel
├── models/
│   ├── mp_oauth_account.dart               # Modelo de cuenta MP
│   ├── mp_oauth_base_response.dart         # Respuesta base
│   ├── mp_oauth_callback_request.dart      # Request de callback
│   ├── mp_oauth_initiate_request.dart      # Request de inicio
│   ├── mp_oauth_initiate_response.dart     # Response de inicio
│   ├── mp_oauth_status_response.dart       # Response de estado
│   └── mp_oauth_models.dart                # Export barrel
├── services/
│   └── mp_oauth_service.dart               # Servicio de alto nivel
├── examples/
│   └── mp_oauth_example.dart               # Ejemplo completo
├── mp_oauth.dart                           # Export principal
├── MP_OAUTH_DOCUMENTATION.md              # Documentación detallada
└── README.md                               # Este archivo
```

## 🚀 Instalación y Configuración

### 1. Importar en tu proyecto

```dart
import 'package:menu_dart_api/menu_com_api.dart';
// Esto incluye automáticamente toda la funcionalidad OAuth de MP
```

### 2. Configurar API base

```dart
void main() {
  // Configurar la URL base de tu API
  API.getInstance('https://tu-api-backend.com');
  
  runApp(MyApp());
}
```

### 3. Autenticar usuario

```dart
// Antes de usar OAuth, el usuario debe estar autenticado
API.setAccessToken('jwt_token_del_usuario');
```

## 💡 Uso Rápido

### Opción 1: Servicio de Alto Nivel (Recomendado)

```dart
final mpService = MPOAuthService();

// Verificar si hay cuenta vinculada
final isLinked = await mpService.isAccountLinked();

// Iniciar vinculación
final authUrl = await mpService.startLinking('https://tuapp.com/callback');
// Redirigir usuario a authUrl

// Completar vinculación (en callback page)
final success = await mpService.completeLinking(authCode, redirectUri);

// Desvincular cuenta
final unlinked = await mpService.unlinkAccount();
```

### Opción 2: Casos de Uso Individuales

```dart
// Importar casos de uso específicos
final initiateUseCase = InitiateMPOAuthUseCase();
final statusUseCase = GetMPOAuthStatusUseCase();

// Usar casos de uso individuales
final request = MPOAuthInitiateRequest(
  redirectUri: 'https://tuapp.com/callback',
);

final response = await initiateUseCase.execute(request);
final authUrl = response.authorizationUrl;
```

## 📱 Integración en Flutter

### Widget de Vinculación

```dart
class MPLinkingButton extends StatefulWidget {
  @override
  _MPLinkingButtonState createState() => _MPLinkingButtonState();
}

class _MPLinkingButtonState extends State<MPLinkingButton> {
  final MPOAuthService _mpService = MPOAuthService();
  bool _isLinked = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final linked = await _mpService.isAccountLinked();
    setState(() => _isLinked = linked);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLinked ? _unlinkAccount : _linkAccount,
      child: Text(_isLinked ? 'Desvincular MP' : 'Vincular MP'),
    );
  }

  Future<void> _linkAccount() async {
    final authUrl = await _mpService.startLinking('https://tuapp.com/callback');
    // Abrir authUrl en navegador o WebView
    await launch(authUrl);
  }

  Future<void> _unlinkAccount() async {
    final success = await _mpService.unlinkAccount();
    if (success) _checkStatus();
  }
}
```

## 🔄 Endpoints Backend Requeridos

Esta implementación requiere que tu backend tenga estos endpoints:

- `POST /payments/oauth/initiate` - Iniciar OAuth
- `POST /payments/oauth/callback` - Completar OAuth  
- `GET /payments/oauth/status` - Verificar estado
- `POST /payments/oauth/unlink` - Desvincular cuenta
- `POST /payments/oauth/refresh-token` - Refrescar token

## 📝 Casos de Uso Incluidos

### 1. `InitiateMPOAuthUseCase`
- **Propósito**: Iniciar proceso de vinculación OAuth
- **Input**: `MPOAuthInitiateRequest`
- **Output**: `MPOAuthInitiateResponse` (con URL de autorización)

### 2. `CompleteMPOAuthUseCase` 
- **Propósito**: Completar vinculación con código de autorización
- **Input**: `MPOAuthCallbackRequest`
- **Output**: `MPOAuthBaseResponse`

### 3. `GetMPOAuthStatusUseCase`
- **Propósito**: Verificar estado de vinculación
- **Input**: Ninguno
- **Output**: `MPOAuthStatusResponse`

### 4. `UnlinkMPAccountUseCase`
- **Propósito**: Desvincular cuenta de Mercado Pago
- **Input**: Ninguno  
- **Output**: `MPOAuthBaseResponse`

### 5. `RefreshMPTokenUseCase`
- **Propósito**: Refrescar token de acceso
- **Input**: Ninguno
- **Output**: `MPOAuthBaseResponse`

## 🛠️ Características Avanzadas

### Servicio de Alto Nivel
- Flujos automáticos de vinculación
- Manejo de errores integrado
- Helpers para tareas comunes
- Refresh automático de tokens

### Validaciones Integradas
- Parámetros requeridos
- Códigos de autorización válidos
- Estados de seguridad
- Manejo de respuestas HTTP

### Flexibilidad
- Uso individual de casos de uso
- Configuración personalizada
- Estados de seguridad customizables
- Múltiples niveles de abstracción

## 🔒 Seguridad

- Validación de parámetros de entrada
- Manejo seguro de tokens
- Estados CSRF protection
- Headers de autorización automáticos
- Refresh automático de tokens

## 📖 Documentación Adicional

- Ver `MP_OAUTH_DOCUMENTATION.md` para documentación detallada
- Ver `examples/mp_oauth_example.dart` para ejemplos completos
- Consultar la documentación del backend para configuración de endpoints

## 🤝 Contribuir

1. Esta implementación sigue los patrones establecidos en `menu_dart_api`
2. Todos los casos de uso incluyen documentación y ejemplos
3. Los modelos siguen las convenciones de serialización JSON
4. El provider usa el cliente HTTP compartido de la API

## 📞 Soporte

Para soporte técnico:
1. Revisar la documentación detallada
2. Verificar ejemplos de uso
3. Validar configuración del backend
4. Revisar logs de errores de la API
