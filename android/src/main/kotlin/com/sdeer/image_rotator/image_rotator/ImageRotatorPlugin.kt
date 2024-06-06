package com.sdeer.image_rotator.image_rotator

import ImageRotator
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File
import java.util.concurrent.Executors

/** ImageRotatorPlugin */
class ImageRotatorPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "image_rotator")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "rotate") {
      val path = call.argument<String>("path")
      val angle = call.argument<Double>("angle")
      val outputPath = call.argument<String>("outputPath")

      if(path == null || angle == null || outputPath == null) {
        result.error("Invalid_Arguments", "path, angle, outputPath must not be null", "")
        return
      }

      val executor = Executors.newSingleThreadExecutor()
      executor.execute {
        val rotator = ImageRotator()
        rotator.rotateImage(File(path), angle.toFloat(), File(outputPath))
        result.success(outputPath)
      }

      executor.shutdown()
    } else {
      result.notImplemented()
    }
  }
  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
