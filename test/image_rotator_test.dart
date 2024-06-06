// import 'package:flutter_test/flutter_test.dart';
// import 'package:image_rotator/image_rotator.dart';
// import 'package:image_rotator/image_rotator_platform_interface.dart';
// import 'package:image_rotator/image_rotator_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockImageRotatorPlatform
//     with MockPlatformInterfaceMixin
//     implements ImageRotatorPlatform {

//   @override
//   Future<String?> g() => Future.value('42');
// }

// void main() {
//   final ImageRotatorPlatform initialPlatform = ImageRotatorPlatform.instance;

//   test('$MethodChannelImageRotator is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelImageRotator>());
//   });

//   test('getPlatformVersion', () async {
//     ImageRotator imageRotatorPlugin = ImageRotator();
//     MockImageRotatorPlatform fakePlatform = MockImageRotatorPlatform();
//     ImageRotatorPlatform.instance = fakePlatform;

//    // expect(await imageRotatorPlugin.getPlatformVersion(), '42');
//   });
// }
