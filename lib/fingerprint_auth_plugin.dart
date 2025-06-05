import 'package:flutter/services.dart';

class FingerprintAuthPlugin {
  static const MethodChannel _channel = MethodChannel('fingerprint_auth_plugin');

  /// Authenticate the user using biometrics (fingerprint or face).
  /// Returns [true] if authentication is successful, [false] otherwise.
  ///
  /// This method will typically show a system UI for biometric authentication.
  ///
  /// Throws [PlatformException] if there's an issue with the platform call
  /// (e.g., biometrics not available, permissions not granted).
  static Future<bool> authenticateFingerprint() async {
    try {
      // Appelle la méthode native 'authenticateFingerprint'
      final bool? success = await _channel.invokeMethod('authenticateFingerprint');
      return success ?? false; // Retourne false si le succès est nul (devrait être true ou false)
    } on PlatformException catch (e) {
      // Gérer les erreurs spécifiques de la plateforme ici
      print("Erreur d'authentification biométrique: ${e.message}");
      return false;
    }
  }
}
