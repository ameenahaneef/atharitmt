import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

void speakStatus(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  // Function to speak text aloud
  void speakStatusAuto(String status) async {
    if (status.isNotEmpty) {
      await flutterTts.speak(status);
    }
  }
