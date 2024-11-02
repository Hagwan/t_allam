import 'dart:convert';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;

class TranscriptionService {
  static Future<String> transcribeAudio(String filePath) async {
    final apiUrl = 'https://api-inference.huggingface.co/models/openai/whisper-large-v3-turbo';
    final apiToken = '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'; // Add your API token here
    final headers = {
      "Authorization": "Bearer $apiToken",
      "Content-Type": "application/octet-stream",
    };

    try {
      final audioBytes = await File(filePath).readAsBytes();
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: audioBytes,
      );

      if (response.statusCode == 200) {
        return utf8.decode(response.bodyBytes);
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "An error occurred: $e";
    }
  }
}

Future<String> startAudioRecording(FlutterSoundRecorder recorder) async {
  Directory tempDir = Directory.systemTemp;
  String filePath = "${tempDir.path}/audio.wav";
  await recorder.startRecorder(
    toFile: filePath,
    codec: Codec.pcm16WAV,
  );
  return filePath;
}
