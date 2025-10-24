import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:battery_plus/battery_plus_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelBatteryPlus platform = MethodChannelBatteryPlus();
  const MethodChannel channel = MethodChannel('battery_plus');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return 42;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getBatteryLevel', () async {
    expect(await platform.getBatteryLevel(), 42);
  });
}
