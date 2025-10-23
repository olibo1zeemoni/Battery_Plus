import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'battery_plus_platform_interface.dart';

/// An implementation of [BatteryPlusPlatform] that uses method channels.
class MethodChannelBatteryPlus extends BatteryPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('battery_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
