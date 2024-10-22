import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class SpeechToTextPage extends StatefulWidget {
  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String _transcribedText = "";

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }

  Future<void> _startRecording() async {
    Directory tempDir = Directory.systemTemp;
    String filePath = "${tempDir.path}/audio.wav";
    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    String? filePath = await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });

    if (filePath != null) {
      String transcribedText = await _transcribeAudio(File(filePath));
      setState(() {
        _transcribedText = transcribedText;
      });
    }
  }

 Future<String> _transcribeAudio(File audioFile) async {
  final apiUrl = 'https://api-inference.huggingface.co/models/openai/whisper-large-v3-turbo';
  final apiToken = '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'; // Add your API token here
  final headers = {
    "Authorization": "Bearer $apiToken",
    "Content-Type": "application/octet-stream",
  };

  try {
    final audioBytes = await audioFile.readAsBytes();
    
    // Sending the audio bytes with the correct headers
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: audioBytes,
    );

    // Ensure the response is decoded as UTF-8
    if (response.statusCode == 200) {
      final result = utf8.decode(response.bodyBytes);  // Decode response using UTF-8
      return result; // Return the transcribed text as a string
    } else {
      return "Error: ${response.statusCode} - ${response.body}";
    }
  } catch (e) {
    return "An error occurred: $e";
  }
}

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech to Text Transcription"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isRecording ? null : _startRecording,
              child: Text('Start Recording'),
            ),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : null,
              child: Text('Stop Recording'),
            ),
            SizedBox(height: 20),
            Text(
              'Transcribed Text:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(_transcribedText),
            //add print(_transcribedText) to console to see the transcribed text
          ],
        ),
      ),
    );
  }
}
