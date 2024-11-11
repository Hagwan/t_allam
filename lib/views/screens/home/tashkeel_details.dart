import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:t_allam/models/speech_model.dart'; // Import the ArabicAlphabetModel class

class tashkeelDetailScreen extends StatefulWidget {
  final String groupName;
  final List<String> letters;

  const tashkeelDetailScreen({
    Key? key,
    required this.groupName,
    required this.letters,
  }) : super(key: key);

  @override
  _tashkeelDetailScreenState createState() => _tashkeelDetailScreenState();
}

class _tashkeelDetailScreenState extends State<tashkeelDetailScreen> {
  final ArabicAlphabetModel _speechModel = ArabicAlphabetModel();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Map of letter display to pronunciation for the Speech API
  final Map<String, String> _pronunciationMap2 = {
    'أُ': 'أو',
    'أِ': 'إيي',
    'أَ': 'أا',
    'بَ': 'با',
    'بُ': 'بو',
    'بِ': 'بي',
    'تَ': 'تا',
    'تُ': 'تو',
    'تِ': 'تي',
    'ثَ': 'ثا',
    'ثُ': 'ثو',
    'ثِ': 'ثي',
    'جَ': 'جا',
    'جُ': 'جو',
    'جِ': 'جي',
    'حَ': 'حا',
    'حُ': 'حو',
    'حِ': 'حي',
    'خَ': 'خا',
    'خُ': 'خو',
    'خِ': 'خي',
    'دَ': 'دا',
    'دُ': 'دو',
    'دِ': 'دي',
    'ذَ': 'ذا',
    'ذُ': 'ذو',
    'ذِ': 'ذي',
    'رَ': 'را',
    'رُ': 'رو',
    'رِ': 'ري',
    'زَ': 'زا',
    'زُ': 'زو',
    'زِ': 'زي',
    'سَ': 'سا',
    'سُ': 'سو',
    'سِ': 'سي',
    'شَ': 'شا',
    'شُ': 'شو',
    'شِ': 'شي',
    'صَ': 'صا',
    'صُ': 'صو',
    'صِ': 'صي',
    'ضَ': 'ضا',
    'ضُ': 'ضو',
    'ضِ': 'ضي',
    'طَ': 'طا',
    'طُ': 'طو',
    'طِ': 'طي',
    'ظَ': 'ظا',
    'ظُ': 'ظو',
    'ظِ': 'ظي',
    'عَ': 'عا',
    'عُ': 'عو',
    'عِ': 'عي',
    'غَ': 'غا',
    'غُ': 'غو',
    'غِ': 'غي',
    'فَ': 'فا',
    'فُ': 'فو',
    'فِ': 'في',
    'قَ': 'قا',
    'قُ': 'قو',
    'قِ': 'قي',
    'كَ': 'كا',
    'كُ': 'كو',
    'كِ': 'كي',
    'لَ': 'لا',
    'لُ': 'لو',
    'لِ': 'لي',
    'مَ': 'ما',
    'مُ': 'مو',
    'مِ': 'مي',
    'نَ': 'نا',
    'نُ': 'نو',
    'نِ': 'ني',
    'هَ': 'ها',
    'هُ': 'هو',
    'هِ': 'هي',
    'وَ': 'وا',
    'وُ': 'وو',
    'وِ': 'وي',
    'يَ': 'يا',
    'يُ': 'يو',
    'يِ': 'يي',
  };

  Future<void> _playLetterSound(String letter) async {
    // Convert the letter to its pronunciation for the API
    final pronunciation = _pronunciationMap2[letter] ?? letter;

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
                  '2',
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
