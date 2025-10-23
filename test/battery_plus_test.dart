import 'package:flutter_test/flutter_test.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:battery_plus/battery_plus_platform_interface.dart';
import 'package:battery_plus/battery_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBatteryPlusPlatform
    with MockPlatformInterfaceMixin
    implements BatteryPlusPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BatteryPlusPlatform initialPlatform = BatteryPlusPlatform.instance;

  test('$MethodChannelBatteryPlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBatteryPlus>());
  });

  test('getPlatformVersion', () async {
    BatteryPlus batteryPlusPlugin = BatteryPlus();
    MockBatteryPlusPlatform fakePlatform = MockBatteryPlusPlatform();
    BatteryPlusPlatform.instance = fakePlatform;

    expect(await batteryPlusPlugin.getPlatformVersion(), '42');
  });
}
