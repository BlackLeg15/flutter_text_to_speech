
import 'flutter_text_to_speech_platform_interface.dart';

class FlutterTextToSpeech {
  Future<void> speak(String text) {
    return FlutterTextToSpeechPlatform.instance.speak(text);
  }
}
