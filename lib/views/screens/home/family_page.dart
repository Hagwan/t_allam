import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:t_allam/models/speech_model.dart';
import 'package:t_allam/models/image_generator_model.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FamilyLessonPage extends StatefulWidget {
  const FamilyLessonPage({super.key});

  @override
  _FamilyLessonPageState createState() => _FamilyLessonPageState();
}

class _FamilyLessonPageState extends State<FamilyLessonPage> {
  final ArabicAlphabetModel _speechModel = ArabicAlphabetModel();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final PoemGenerator _poemGenerator =
      PoemGenerator(); // Initialize poem generator
  String? _imageUrl;
  bool _isLoading = false;
  bool _hasError = false;
  String _displayText = 'اليوم سنتعرف على أفراد العائلة'; // Initial text

  Future<void> _playSpeechAndGenerateImage(
      String arabicText, String englishText) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _imageUrl = null;
      _displayText =
          'جاري إنشاء القصيدة...'; // Loading message for poem generation
    });

    // Play the speech
    final audioBytes = await _speechModel.speakText(arabicText);
    if (audioBytes != null) {
      Uint8List audioUint8List = Uint8List.fromList(audioBytes);
      await _audioPlayer.play(BytesSource(audioUint8List));
    } else {
      print('Failed to generate audio for "$arabicText".');
    }

    // Generate the poem
    try {
      final poem = await _poemGenerator.generatePoem(arabicText);
      setState(() {
        _displayText = poem; // Update the text with the generated poem
      });
    } catch (e) {
      setState(() {
        _displayText = 'فشل في إنشاء القصيدة'; // Error message
      });
      print('Error generating poem: $e');
    }

    // Generate the image
    try {
      final imageResult = await generateImageFromPrompt(englishText);
      if (imageResult['status'] == 'success') {
        setState(() {
          _imageUrl = imageResult['imageUrl'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print('Error generating image: $e');
    }
  }

  Future<void> _playPoemSpeech() async {
    if (_displayText.isNotEmpty) {
      final audioBytes = await _speechModel.speakText(_displayText);
      if (audioBytes != null) {
        Uint8List audioUint8List = Uint8List.fromList(audioBytes);
        await _audioPlayer.play(BytesSource(audioUint8List));
      } else {
        print('Failed to generate audio for the poem.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          image: const DecorationImage(
            image: AssetImage('lib/assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 30),
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
                Center(
                  child: Image.asset(
                    'lib/assets/images/Allam.png',
                    width: 60,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon:
                      const Icon(Icons.volume_up, color: Colors.blue, size: 30),
                  onPressed: _playPoemSpeech, // Play the poem as speech
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _displayText,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        _buildSpeechButton(
                            'أبي', 'Father with Sons in home', 'أبي'),
                        _buildSpeechButton('أمي', 'Mother ', 'أمي'),
                        _buildSpeechButton('أختي', 'Sister', 'أختي'),
                      ],
                    ),
                    Column(
                      children: [
                        _buildSpeechButton('أخي', 'Brother', 'أخي'),
                        _buildSpeechButton('جدي', 'Grandfather', 'جدي'),
                        _buildSpeechButton('جدتي', 'Grandmother', 'جدتي'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 120,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _hasError
                          ? const Center(
                              child: Text('Image not available',
                                  style: TextStyle(color: Colors.red)))
                          : _imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.memory(
                                    base64Decode(_imageUrl!.split(',')[1]),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset('lib/assets/images/family.png',
                                  fit: BoxFit.contain),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 30),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.check,
                          color: Colors.white, size: 30),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeechButton(
      String arabicText, String englishText, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => _playSpeechAndGenerateImage(arabicText, englishText),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class PoemGenerator {
  final String apiKey = dotenv.env['API_KEY']!;
  final String tokenUrl = 'https://iam.cloud.ibm.com/identity/token';
  final String generateUrl =
      'https://eu-de.ml.cloud.ibm.com/ml/v1/text/generation?version=2023-05-29';

  Future<String> getIbMToken() async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = {
      'grant_type': 'urn:ibm:params:oauth:grant-type:apikey',
      'apikey': apiKey,
    };

    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final resFormat = json.decode(response.body);
      return resFormat['access_token'];
    } else {
      throw Exception('Error: ${response.statusCode}\n${response.body}');
    }
  }

  Future<String> generatePoem(String word) async {
    final token = await getIbMToken();

    final body = {
      "input": """
النص الإرشادي:
\"خذ كلمة عربية كمدخل وألّف قصيدة من ثلاثة أسطر حولها. في القصيدة:

1. اشرح أهمية الكلمة بطريقة يمكن للأطفال فهمها.
2. أظهر الحب أو الإعجاب بالكلمة.
3. اجعل الأسلوب ودودًا ولطيفًا ومناسبًا للأطفال من سن 3 إلى 11 سنة.\"

Input: أمي
Output: مي حنانٌ يملأ قلبي بالأمان،
كالزهرةِ التي تبتسم لي كلَّ صباح،
في حضنها أجد الراحة والسلام.

Input: أبي
Output: أبي قوةٌ تحميني في كلِّ مكان،
سندي وأمانٌ كالجبلِ العالي،
بقربه أشعر بالدفء والأمان.

Input: أختي
Output: أختي صديقةٌ تملأ حياتي بالضحك،
نلعب معًا ونحلم بالأماني،
معها كلُّ يومٍ يزهر كالبستان.

Input: أخي
Output: أخي رفيقٌ يرافقني في كلِّ مغامرة،
نضحك ونركض ونكتشف الحياة،
وفي قربه أجد الفرحة والأمان.

Input: جدي
Output: 
جدي حكمةٌ كالنهر الجاري بالخير،
يحكي لي قصصَ الزمن الجميل،
وفي كلماته دروسٌ وأمان.

Input: جدتي
Output: جدتي حنانٌ يفيض كالعطرِ الجميل،
تقصُّ عليَّ حكاياتِ الحبِّ والوداد،
وفي حضنها أجد السكينة والراحة

Input: $word
Output:""",
      "parameters": {
        "decoding_method": "greedy",
        "max_new_tokens": 200,
        "stop_sequences": ["."],
        "repetition_penalty": 1
      },
      "model_id": "sdaia/allam-1-13b-instruct",
      "project_id": "10ee99ea-e10e-49f6-8126-1ac689449710"
    };

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.post(
      Uri.parse(generateUrl),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return data['results'][0]['generated_text'].trim();
    } else {
      throw Exception('Failed to generate poem: ${response.body}');
    }
  }
}
