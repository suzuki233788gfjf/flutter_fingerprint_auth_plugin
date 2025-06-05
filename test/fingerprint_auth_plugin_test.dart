import 'package:flutter_test/flutter_test.dart';
import 'package:fingerprint_auth_plugin/fingerprint_auth_plugin.dart';
import 'package:fingerprint_auth_plugin/fingerprint_auth_plugin_platform_interface.dart';
import 'package:fingerprint_auth_plugin/fingerprint_auth_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFingerprintAuthPluginPlatform
    with MockPlatformInterfaceMixin
    implements FingerprintAuthPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FingerprintAuthPluginPlatform initialPlatform = FingerprintAuthPluginPlatform.instance;

  test('$MethodChannelFingerprintAuthPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFingerprintAuthPlugin>());
  });

  test('getPlatformVersion', () async {
    FingerprintAuthPlugin fingerprintAuthPlugin = FingerprintAuthPlugin();
    MockFingerprintAuthPluginPlatform fakePlatform = MockFingerprintAuthPluginPlatform();
    FingerprintAuthPluginPlatform.instance = fakePlatform;

    expect(await fingerprintAuthPlugin.getPlatformVersion(), '42');
  });
}
