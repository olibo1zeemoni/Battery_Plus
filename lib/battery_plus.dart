
// import 'battery_plus_platform_interface.dart';
import 'package:flutter/services.dart';

class BatteryPlus {  static const MethodChannel _channel = MethodChannel('com.example.battery_plus/channel');

  /// Fetches the current battery level from the platform.
  ///
  /// Returns the battery level as an integer percentage.
  /// Throws a [PlatformException] if the battery level cannot be determined.
  Future<int> getBatteryLevel() async {
    try {
      // Invoke the 'getBatteryLevel' method on the native side.
      // The platform will return an integer. If not, the cast will fail.
      final int? level = await _channel.invokeMethod<int>('getBatteryLevel');
      
      if (level == null) {
        throw PlatformException(
          code: 'UNAVAILABLE',
          message: 'Battery level not available.',
        );
      }
      return level;
    } on PlatformException catch (e) {
      // Re-throw the platform exception to the caller.
      throw PlatformException(
        code: e.code,
        message: 'Failed to get battery level: ${e.message}',
      );
    }
  }
}
