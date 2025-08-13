import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_text_to_speech_method_channel.dart';

abstract class FlutterTextToSpeechPlatform extends PlatformInterface {
  /// Constructs a FlutterTextToSpeechPlatform.
  FlutterTextToSpeechPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterTextToSpeechPlatform _instance = MethodChannelFlutterTextToSpeech();

  /// The default instance of [FlutterTextToSpeechPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterTextToSpeech].
  static FlutterTextToSpeechPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterTextToSpeechPlatform] when
  /// they register themselves.
  static set instance(FlutterTextToSpeechPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> speak(String text) async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
