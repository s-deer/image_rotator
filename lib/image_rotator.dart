import 'dart:io';

import 'image_rotator_platform_interface.dart';

class ImageRotator {
  Future<File?> rotateImage(
    File file, {
    required double angle,
    required String outputPath,
  }) {
    return ImageRotatorPlatform.instance.rotateImage(file, angle, outputPath);
  }
}
