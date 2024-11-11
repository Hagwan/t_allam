import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:t_allam/models/speech_model.dart'; // Import the ArabicAlphabetModel class

class LetterDetailScreen extends StatefulWidget {
  final String groupName;
  final List<String> letters;

  const LetterDetailScreen({
    Key? key,
    required this.groupName,
    required this.letters,
  }) : super(key: key);

  @override
  _LetterDetailScreenState createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends State<LetterDetailScreen> {
  final ArabicAlphabetModel _speechModel = ArabicAlphabetModel();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Map of letter display to pronunciation for the Speech API
  final Map<String, String> _pronunciationMap = {
    'أ': 'ألف',
    'ب': 'باء',
    'ت': 'تاء',
    'ث': 'ثاء',
    'ج': 'جيم',
    'ح': 'حاء',
    'خ': 'خاء',
    'د': 'دال',
    'ذ': 'ذال',
    'ر': 'راء',
    'ز': 'زاي',
    'س': 'سين',
    'ش': 'شين',
    'ص': 'صاد',
    'ض': 'ضاد',
    'ط': 'طاء',
    'ظ': 'ظاء',
    'ع': 'عين',
    'غ': 'غين',
    'ف': 'فاء',
    'ق': 'قاف',
    'ك': 'كاف',
    'ل': 'لام',
    'م': 'ميم',
    'ن': 'نون',
    'ه': 'هاء',
    'و': 'واو',
    'ي': 'ياء'
  };

  Future<void> _playLetterSound(String letter) async {
    // Convert the letter to its pronunciation for the API
    final pronunciation = _pronunciationMap[letter] ?? letter;

    final Uint8List? audioData =
        await _speechModel.speakText(pronunciation) as Uint8List?;

    if (audioData != null) {
      await _audioPlayer.play(BytesSource(audioData));
    } else {
      print("Audio generation failed.");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orange.shade300,
          image: const DecorationImage(
            image: AssetImage('lib/assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Character Image
            Center(
              child: Image.asset(
                'lib/assets/images/Allam.png',
                width: 140,
              ),
            ),

            const SizedBox(height: 20),

            // Letter Group Container
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.letters
                      .map((letter) => GestureDetector(
                            onTap: () => _playLetterSound(letter),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                letter,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
