import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'image_rotator_platform_interface.dart';

/// An implementation of [ImageRotatorPlatform] that uses method channels.
class MethodChannelImageRotator extends ImageRotatorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('image_rotator');

  @override
  Future<File?> rotateImage(File file, double angle, String outputPath) async {
    final path = await methodChannel.invokeMethod<String>(
      'rotate',
      {
        'path': file.path,
        'outputPath': outputPath,
        'angle': angle,
      },
    );

    if (path == null) {
      return null;
    }

    return File(path);
  }
}
