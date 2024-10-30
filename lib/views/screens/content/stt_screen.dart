import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../../../models/stt_model.dart';

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
    String filePath = await startAudioRecording(_recorder);
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
      String transcribedText = await TranscriptionService.transcribeAudio(filePath);
      setState(() {
        _transcribedText = transcribedText;
      });
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
          ],
        ),
      ),
    );
  }
}
