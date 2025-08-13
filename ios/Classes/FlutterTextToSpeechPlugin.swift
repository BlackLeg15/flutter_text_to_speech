import Flutter
import UIKit
import AVFoundation

public class FlutterTextToSpeechPlugin: NSObject, FlutterPlugin {
  private var synthesizer: AVSpeechSynthesizer!
  private var textToSpeechChannel: FlutterMethodChannel!

  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = FlutterTextToSpeechPlugin()
    instance.initializeTextToSpeechService()
    instance.initializeTextToSpeechChannel(binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: instance.textToSpeechChannel)
  }

  private func initializeTextToSpeechService() {
    synthesizer = AVSpeechSynthesizer()
  }

  private func initializeTextToSpeechChannel(binaryMessenger: FlutterBinaryMessenger) {
    textToSpeechChannel = FlutterMethodChannel(
      name: "flutter_text_to_speech",
      binaryMessenger: binaryMessenger
    )
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "speak":
      let text = call.arguments as? String
      let isTextNotEmpty = text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
      if let validText = text, isTextNotEmpty {
        let utterance = AVSpeechUtterance(string: validText)
        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        synthesizer?.speak(utterance)
        result(nil)
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "O texto passado está vazio ou nulo.", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
