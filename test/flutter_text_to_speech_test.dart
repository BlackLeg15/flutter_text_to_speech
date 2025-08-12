import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech_platform_interface.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterTextToSpeechPlatform
    with MockPlatformInterfaceMixin
    implements FlutterTextToSpeechPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterTextToSpeechPlatform initialPlatform = FlutterTextToSpeechPlatform.instance;

  test('$MethodChannelFlutterTextToSpeech is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterTextToSpeech>());
  });

  test('getPlatformVersion', () async {
    FlutterTextToSpeech flutterTextToSpeechPlugin = FlutterTextToSpeech();
    MockFlutterTextToSpeechPlatform fakePlatform = MockFlutterTextToSpeechPlatform();
    FlutterTextToSpeechPlatform.instance = fakePlatform;

    expect(await flutterTextToSpeechPlugin.getPlatformVersion(), '42');
  });
}
