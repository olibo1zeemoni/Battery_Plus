
import 'battery_plus_platform_interface.dart';

class BatteryPlus {
  Future<String?> getPlatformVersion() {
    return BatteryPlusPlatform.instance.getPlatformVersion();
  }
}
