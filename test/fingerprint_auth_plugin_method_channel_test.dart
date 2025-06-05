import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fingerprint_auth_plugin/fingerprint_auth_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFingerprintAuthPlugin platform = MethodChannelFingerprintAuthPlugin();
  const MethodChannel channel = MethodChannel('fingerprint_auth_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
