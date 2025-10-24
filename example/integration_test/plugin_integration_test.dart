// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:battery_plus/battery_plus.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getPlatformVersion test', (WidgetTester tester) async {
    final BatteryPlus plugin = BatteryPlus();
    final int level = await plugin.getBatteryLevel();
    
     expect(level, isNotNull, reason: 'Battery level should not be null');
    final int value = level;
    expect(value, greaterThanOrEqualTo(0),
        reason: 'Battery level should be >= 0');
    expect(value, lessThanOrEqualTo(100),
        reason: 'Battery level should be <= 100');
  });

  testWidgets('multiple getBatteryLevel calls return valid percentages',
      (WidgetTester tester) async {
    final BatteryPlus plugin = BatteryPlus();
    final int first = await plugin.getBatteryLevel();
    final int second = await plugin.getBatteryLevel();

    expect(first, isNotNull, reason: 'First battery level should not be null');
    expect(second, isNotNull, reason: 'Second battery level should not be null');

    final int a = first;
    final int b = second;
    expect(a, inInclusiveRange(0, 100),
        reason: 'First battery level should be between 0 and 100');
    expect(b, inInclusiveRange(0, 100),
        reason: 'Second battery level should be between 0 and 100');
  });
}
