package com.example.battery_plus

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** BatteryPlusPlugin */
class BatteryPlusPlugin :
    FlutterPlugin,
    MethodCallHandler {
    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    // Context is required to access system services.
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        // Get the application context from the binding.
        context = flutterPluginBinding.applicationContext
        // Establish the channel. The name MUST match the one in Dart.
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.example.battery_plus/channel")
        // Set this class as the handler for methods called on this channel.
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        // Check which method is being called from Dart.
        if (call.method == "getBatteryLevel") {
            val batteryLevel = getBatteryLevel()
            if (batteryLevel != -1) {
                // Send a success result back to Dart.
                result.success(batteryLevel)
            } else {
                // Send an error result back to Dart.
                result.error("UNAVAILABLE", "Battery level not available.", null)
            }
        } else {
            // Inform Dart that the method is not implemented.
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        // Clean up the channel when the plugin is detached.
        channel.setMethodCallHandler(null)
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        // Modern approach for Android Lollipop (API 21) and newer.
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            // Older approach for pre-Lollipop devices.
            val intent = ContextWrapper(context.applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}