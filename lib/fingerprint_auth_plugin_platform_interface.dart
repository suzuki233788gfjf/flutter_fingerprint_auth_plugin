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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
