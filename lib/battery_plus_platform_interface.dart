import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'battery_plus_method_channel.dart';

abstract class BatteryPlusPlatform extends PlatformInterface {
  /// Constructs a BatteryPlusPlatform.
  BatteryPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static BatteryPlusPlatform _instance = MethodChannelBatteryPlus();

  /// The default instance of [BatteryPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelBatteryPlus].
  static BatteryPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BatteryPlusPlatform] when
  /// they register themselves.
  static set instance(BatteryPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
