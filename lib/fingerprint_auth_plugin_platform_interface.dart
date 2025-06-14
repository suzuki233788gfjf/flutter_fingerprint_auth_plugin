import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fingerprint_auth_plugin_method_channel.dart';

abstract class FingerprintAuthPluginPlatform extends PlatformInterface {
  /// Constructs a FingerprintAuthPluginPlatform.
  FingerprintAuthPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FingerprintAuthPluginPlatform _instance = MethodChannelFingerprintAuthPlugin();

  /// The default instance of [FingerprintAuthPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFingerprintAuthPlugin].
  static FingerprintAuthPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FingerprintAuthPluginPlatform] when
  /// they register themselves.
  static set instance(FingerprintAuthPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // >>> Déclarations des méthodes que vous voulez exposer <<<

  /// Checks if biometric authentication is available on the device.
  Future<bool?> canCheckBiometrics() {
    throw UnimplementedError('canCheckBiometrics() has not been implemented.');
  }

  /// Gets the list of available biometrics (e.g., face, fingerprint).
  /// Note: This is an example, typically `canCheckBiometrics` is enough for basic use.
  /// You might want to remove this if not strictly needed.
  Future<List<String>?> getAvailableBiometrics() {
    throw UnimplementedError('getAvailableBiometrics() has not been implemented.');
  }

  /// Authenticates the user using biometrics.
  /// Returns true if authentication is successful, false otherwise.
  Future<bool?> authenticate() {
    throw UnimplementedError('authenticate() has not been implemented.');
  }
}
