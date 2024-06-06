import 'dart:io';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'image_rotator_method_channel.dart';

abstract class ImageRotatorPlatform extends PlatformInterface {
  /// Constructs a ImageRotatorPlatform.
  ImageRotatorPlatform() : super(token: _token);

  static final Object _token = Object();

  static ImageRotatorPlatform _instance = MethodChannelImageRotator();

  /// The default instance of [ImageRotatorPlatform] to use.
  ///
  /// Defaults to [MethodChannelImageRotator].
  static ImageRotatorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ImageRotatorPlatform] when
  /// they register themselves.
  static set instance(ImageRotatorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<File?> rotateImage(File file, double angle, String outputPath) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
