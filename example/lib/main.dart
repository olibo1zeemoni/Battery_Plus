import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:battery_plus/battery_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _batteryPlus = BatteryPlus();
  String _batteryLevel = 'Unknown battery level.';
  bool _isLoading = false;

  Future<void> _getBatteryLevel() async {
    setState(() {
      _isLoading = true;
      _batteryLevel = 'Fetching...';
    });
  
    String batteryLevel;
    try {
      final level = await _batteryPlus.getBatteryLevel();
      batteryLevel = '$level%';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    if (!mounted) return;

    setState(() {
      _batteryLevel = batteryLevel;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Battery Plus Plugin Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _batteryLevel,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _getBatteryLevel,
                child: const Text('Get Battery Level'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}