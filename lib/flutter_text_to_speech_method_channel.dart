import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_text_to_speech_platform_interface.dart';

/// An implementation of [FlutterTextToSpeechPlatform] that uses method channels.
class MethodChannelFlutterTextToSpeech extends FlutterTextToSpeechPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_text_to_speech');

  @override
  Future<void> speak(String text) async {
    await methodChannel.invokeMethod('speak', text);
  }
}
