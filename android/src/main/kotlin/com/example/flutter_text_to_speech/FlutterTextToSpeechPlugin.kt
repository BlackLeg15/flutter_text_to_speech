package com.example.flutter_text_to_speech

import android.content.Context
import android.speech.tts.TextToSpeech
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

/** FlutterTextToSpeechPlugin */
class FlutterTextToSpeechPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var textToSpeechChannel : MethodChannel
  private lateinit var textToSpeechService: TextToSpeech

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    initializeTextToSpeechChannel(flutterPluginBinding.binaryMessenger)
    initializeTextToSpeechService(flutterPluginBinding.applicationContext)
  }

  private fun initializeTextToSpeechChannel(binaryMessenger: BinaryMessenger) {
    textToSpeechChannel = MethodChannel(
      binaryMessenger, "flutter_text_to_speech"
    )
    textToSpeechChannel.setMethodCallHandler(this)
  }

  private fun initializeTextToSpeechService(context: Context) {
    textToSpeechService = TextToSpeech(context) {
      if (it == TextToSpeech.SUCCESS) {
        textToSpeechService.language = Locale.forLanguageTag("BR")
      }
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "speak") {
      val text = call.arguments<String>()
      if (text.isNullOrBlank()) {
        result.error(
          "INVALID_ARGUMENT",
          "O texto passado está vazio ou nulo.",
          null
        )
        return
      }
      textToSpeechService.speak(text, TextToSpeech.QUEUE_FLUSH, null, null)
      result.success(null)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    textToSpeechService.shutdown()
    textToSpeechChannel.setMethodCallHandler(null)
  }
}
