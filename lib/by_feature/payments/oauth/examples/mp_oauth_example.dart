import 'package:menu_dart_api/menu_com_api.dart';

/// Ejemplo completo de integración OAuth de Mercado Pago
///
/// Este ejemplo muestra cómo usar los casos de uso de OAuth de Mercado Pago
/// en una aplicación Flutter real.
class MPOAuthIntegrationExample {
  // Instancia del servicio principal
  final MPOAuthService _mpOAuthService = MPOAuthService();

  // Configuración de redirect URI (debe coincidir con MP Developers)
  static const String redirectUri = 'https://tuapp.com/oauth/callback';

  /// 1. Verificar estado inicial de vinculación
  Future<void> checkInitialState() async {
    print('🔍 Verificando estado de vinculación...');

    try {
      final status = await _mpOAuthService.getAccountStatus();

      if (status.isLinked) {
        print('✅ Cuenta ya vinculada:');
        print('   📧 Email: ${status.account?.email}');
        print('   🏷️  Nickname: ${status.account?.nickname}');
        print('   🌍 País: ${status.account?.country}');
        print('   📊 Estado: ${status.account?.status}');
      } else {
        print('❌ No hay cuenta vinculada');
      }
    } catch (e) {
      print('⚠️ Error al verificar estado: $e');
    }
  }

  /// 2. Flujo completo de vinculación
  Future<String?> startLinkingProcess() async {
    print('🚀 Iniciando proceso de vinculación...');

    try {
      // Usar el flujo helper que maneja todo automáticamente
      final result = await _mpOAuthService.initiateLinkingFlow(redirectUri);

      if (result.isAlreadyLinked) {
        print('ℹ️ Ya hay una cuenta vinculada: ${result.linkedEmail}');
        return null;
      } else if (result.hasAuthUrl) {
        print('🔗 URL de autorización generada: ${result.authUrl}');
        print('👆 Redirige al usuario a esta URL');
        return result.authUrl;
      } else {
        print('❌ Error en el flujo: ${result.error}');
        return null;
      }
    } catch (e) {
      print('⚠️ Error al iniciar vinculación: $e');
      return null;
    }
  }

  /// 3. Completar vinculación (llamar desde callback page)
  Future<bool> completeLinkinFromCallback(String authorizationCode) async {
    print('🔄 Completando vinculación...');
    print('📝 Código recibido: ${authorizationCode.substring(0, 10)}...');

    try {
      final success = await _mpOAuthService.completeLinking(
        authorizationCode,
        redirectUri,
      );

      if (success) {
        print('🎉 ¡Vinculación completada exitosamente!');
        // Verificar el estado final
        await checkInitialState();
        return true;
      } else {
        print('❌ Error al completar vinculación');
        return false;
      }
    } catch (e) {
      print('⚠️ Error en callback: $e');
      return false;
    }
  }

  /// 4. Desvincular cuenta
  Future<bool> unlinkAccount() async {
    print('🔓 Desvinculando cuenta...');

    try {
      final success = await _mpOAuthService.unlinkAccount();

      if (success) {
        print('✅ Cuenta desvinculada exitosamente');
        return true;
      } else {
        print('❌ Error al desvincular cuenta');
        return false;
      }
    } catch (e) {
      print('⚠️ Error al desvincular: $e');
      return false;
    }
  }

  /// 5. Mantener token válido
  Future<void> ensureValidToken() async {
    print('🔄 Verificando validez del token...');

    try {
      final isValid = await _mpOAuthService.ensureValidToken();

      if (isValid) {
        print('✅ Token válido');
      } else {
        print('⚠️ Token inválido o no hay cuenta vinculada');
      }
    } catch (e) {
      print('⚠️ Error al verificar token: $e');
    }
  }

  /// 6. Ejemplo de uso con casos de uso individuales
  Future<void> advancedUsageExample() async {
    print('🔧 Ejemplo de uso avanzado...');

    // Instanciar casos de uso individuales
    final initiateUseCase = InitiateMPOAuthUseCase();
    final statusUseCase = GetMPOAuthStatusUseCase();
    final refreshUseCase = RefreshMPTokenUseCase();

    try {
      // 1. Verificar estado
      final status = await statusUseCase.execute();
      print('Estado: ${status.isLinked ? "Vinculado" : "No vinculado"}');

      // 2. Si está vinculado, refrescar token silenciosamente
      if (status.isLinked) {
        final refreshed = await refreshUseCase.executeSilently();
        print('Token refrescado: ${refreshed ? "Sí" : "No"}');
      } else {
        // 3. Si no está vinculado, generar URL personalizada
        final request = initiateUseCase.createRequest(
          redirectUri: redirectUri,
          customState: 'advanced_flow_${DateTime.now().millisecondsSinceEpoch}',
        );

        final response = await initiateUseCase.execute(request);
        print('URL personalizada: ${response.authorizationUrl}');
        print('Estado de seguridad: ${response.state}');
      }
    } catch (e) {
      print('Error en uso avanzado: $e');
    }
  }

  /// 7. Simulación de flujo completo
  Future<void> runCompleteFlow() async {
    print('🎯 Ejecutando flujo completo de ejemplo...\n');

    // Paso 1: Verificar estado inicial
    await checkInitialState();
    print('');

    // Paso 2: Iniciar vinculación si no está vinculada
    final authUrl = await startLinkingProcess();
    print('');

    if (authUrl != null) {
      print('📱 En tu aplicación, redirigirías al usuario a: $authUrl');
      print('⏳ Esperando que el usuario autorice...');
      print('');

      // Simular que el usuario autorizó y recibimos el código
      // (En la realidad, esto vendría del callback)
      const simulatedAuthCode = 'SIMULATED_AUTH_CODE_123456';

      print('📞 Simulando callback con código de autorización...');
      final completed = await completeLinkinFromCallback(simulatedAuthCode);
      print('');

      if (completed) {
        print('🎊 ¡Flujo completado exitosamente!');
      }
    }

    // Paso 3: Mostrar uso avanzado
    await advancedUsageExample();
    print('');

    // Paso 4: Verificar token
    await ensureValidToken();
    print('');

    print('✨ Ejemplo completado');
  }
}

/// Función principal para ejecutar el ejemplo
Future<void> main() async {
  // Configurar la API (esto se haría en tu app al inicializar)
  API.getInstance('https://tu-api.com');
  // API.setAccessToken('tu_jwt_token_aqui');

  final example = MPOAuthIntegrationExample();
  await example.runCompleteFlow();
}

/// Ejemplo de widget Flutter que usa la integración
/*
import 'package:flutter/material.dart';

class MPAccountSettingsPage extends StatefulWidget {
  @override
  _MPAccountSettingsPageState createState() => _MPAccountSettingsPageState();
}

class _MPAccountSettingsPageState extends State<MPAccountSettingsPage> {
  final MPOAuthIntegrationExample _integration = MPOAuthIntegrationExample();
  bool _isLinked = false;
  bool _isLoading = false;
  String? _accountEmail;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    setState(() => _isLoading = true);
    
    final service = MPOAuthService();
    final isLinked = await service.isAccountLinked();
    final email = await service.getLinkedAccountEmail();
    
    setState(() {
      _isLinked = isLinked;
      _accountEmail = email;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración de Mercado Pago')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (_isLoading)
              CircularProgressIndicator()
            else if (_isLinked)
              Card(
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: Colors.green),
                  title: Text('Cuenta Vinculada'),
                  subtitle: Text(_accountEmail ?? 'Email no disponible'),
                  trailing: IconButton(
                    icon: Icon(Icons.link_off),
                    onPressed: () async {
                      final success = await _integration.unlinkAccount();
                      if (success) _checkStatus();
                    },
                  ),
                ),
              )
            else
              Card(
                child: ListTile(
                  leading: Icon(Icons.account_balance_wallet, color: Colors.grey),
                  title: Text('Cuenta No Vinculada'),
                  subtitle: Text('Vincula tu cuenta de Mercado Pago'),
                  trailing: IconButton(
                    icon: Icon(Icons.link),
                    onPressed: () async {
                      final authUrl = await _integration.startLinkingProcess();
                      if (authUrl != null) {
                        // Abrir URL en navegador o WebView
                        // await launch(authUrl);
                      }
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
*/
