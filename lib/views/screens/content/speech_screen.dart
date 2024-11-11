import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../models/speech_model.dart';
import 'dart:typed_data'; // Add this import for Uint8List


class ArabicAlphabetScreens extends StatefulWidget {
  @override
  _ArabicAlphabetScreenState createState() => _ArabicAlphabetScreenState();
}

class _ArabicAlphabetScreenState extends State<ArabicAlphabetScreens> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final TextEditingController _textController = TextEditingController();
  final ArabicAlphabetModel _model = ArabicAlphabetModel();

Future<void> _speakText(String text) async {
  final audioBytes = await _model.speakText(text);
  if (audioBytes != null) {
    // Convert List<int> to Uint8List
    await _audioPlayer.play(BytesSource(Uint8List.fromList(audioBytes)));
  } else {
    print('Failed to generate speech.');
  }
}

  @override
  void dispose() {
    _audioPlayer.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // Handle menu action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'أدخل النص هنا', // "Enter text here" in Arabic
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String textToSpeak = _textController.text;
                    if (textToSpeak.isNotEmpty) {
                      _speakText(textToSpeak);
                    }
                  },
                ),
              ),
              maxLines: 3, // Allow multiple lines
            ),
            SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Image.asset(
                  'lib/assets/images/character.png', // Replace with your character image path
                  height: 150,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
