import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();

  Future<bool> init() async {
    return await _speech.initialize(
      onStatus: (status) {
        print("Speech status: $status");

        if (status == "notListening") {
          // helps reset state on web
        }
      },
      onError: (error) {
        print("Speech error: $error");
      },
    );
  }

  Future<void> listen({required Function(String) onResult}) async {
    if (_speech.isListening) {
      return;
    }
    await _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
    );
  }

  void stop() {
    _speech.stop();
  }

  void reset() {
    _speech.cancel();
  }
}
