import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fingerprint_auth_plugin_platform_interface.dart';

/// An implementation of [FingerprintAuthPluginPlatform] that uses method channels.
class MethodChannelFingerprintAuthPlugin extends FingerprintAuthPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fingerprint_auth_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
