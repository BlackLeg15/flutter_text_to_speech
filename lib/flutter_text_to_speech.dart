
import 'flutter_text_to_speech_platform_interface.dart';

class FlutterTextToSpeech {
  Future<String?> getPlatformVersion() {
    return FlutterTextToSpeechPlatform.instance.getPlatformVersion();
  }
}
