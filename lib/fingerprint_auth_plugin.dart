import 'fingerprint_auth_plugin_platform_interface.dart';

class FingerprintAuthPlugin {
  // Pas besoin de changer grand-chose ici, il délègue aux méthodes de l'interface.

  /// Checks if biometric authentication is available on the device.
  Future<bool?> canCheckBiometrics() {
    return FingerprintAuthPluginPlatform.instance.canCheckBiometrics();
  }

  /// Gets the list of available biometrics (e.g., face, fingerprint).
  /// Note: This is an example, typically `canCheckBiometrics` is enough for basic use.
  /// You might want to remove this if not strictly needed.
  Future<List<String>?> getAvailableBiometrics() {
    return FingerprintAuthPluginPlatform.instance.getAvailableBiometrics();
  }

  /// Authenticates the user using biometrics.
  /// Returns true if authentication is successful, false otherwise.
  Future<bool?> authenticate() {
    return FingerprintAuthPluginPlatform.instance.authenticate();
  }
}
