import Flutter
import UIKit

public class BatteryPlusPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        // Establish the channel. The name MUST match the one in Dart.
        let channel = FlutterMethodChannel(name: "com.example.battery_plus/channel", binaryMessenger: registrar.messenger())
        let instance = BatteryPlusPlugin()
        // Set this class as the handler for methods called on this channel.
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        // Check which method is being called from Dart.
        guard call.method == "getBatteryLevel" else {
            // Inform Dart that the method is not implemented.
            result(FlutterMethodNotImplemented)
            return
        }
        // Call our native iOS function.
        getBatteryLevel(result: result)
    }

    private func getBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        // Battery monitoring must be enabled.
        device.isBatteryMonitoringEnabled = true
        
        // Check if the battery level is available.
        if device.batteryState == .unknown {
            // If the state is unknown, send an error.
            result(FlutterError(code: "UNAVAILABLE",
                                message: "Battery level not available.",
                                details: nil))
        } else {
            // Battery level is a float from 0.0 to 1.0. We multiply by 100 to get a percentage.
            // Send a success result back to Dart.
            result(Int(device.batteryLevel * 100))
        }
    }
}
