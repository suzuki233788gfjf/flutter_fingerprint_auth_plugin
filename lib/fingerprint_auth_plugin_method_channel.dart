import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fingerprint_auth_plugin_platform_interface.dart';

/// An implementation of [FingerprintAuthPluginPlatform] that uses method channels.
class MethodChannelFingerprintAuthPlugin extends FingerprintAuthPluginPlatform {
  /// The MethodChannel that is used by the FingerprintAuthPlugin.
  @visibleForTesting
  final methodChannel = const MethodChannel('fingerprint_auth_plugin');

  @override
  Future<bool?> canCheckBiometrics() async {
    final bool? canCheck = await methodChannel.invokeMethod<bool>('canCheckBiometrics');
    return canCheck;
  }

  @override
  Future<List<String>?> getAvailableBiometrics() async {
    // Cette méthode devra être implémentée côté natif si vous la gardez.
    // Pour l'instant, on peut retourner un tableau vide ou null si non implémenté nativement.
    final List<Object?>? biometrics = await methodChannel.invokeListMethod<Object>('getAvailableBiometrics');
    return biometrics?.map((e) => e.toString()).toList();
  }

  @override
  Future<bool?> authenticate() async {
    final bool? isAuthenticated = await methodChannel.invokeMethod<bool>('authenticateFingerprint'); // Changed method name to match native
    return isAuthenticated;
  }
}
