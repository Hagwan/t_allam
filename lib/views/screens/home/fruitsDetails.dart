import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:t_allam/models/speech_model.dart';
import 'package:t_allam/models/image_generator_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FruitsDeatilsScreen extends StatefulWidget {
  final String groupName;
  final List<String> letters;

  const FruitsDeatilsScreen({
    Key? key,
    required this.groupName,
    required this.letters,
  }) : super(key: key);

  @override
  _FruitsDeatilsScreenState createState() => _FruitsDeatilsScreenState();
}

class _FruitsDeatilsScreenState extends State<FruitsDeatilsScreen> {
  final ArabicAlphabetModel _speechModel = ArabicAlphabetModel();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FruitsGenerator _fruitsGenerator = FruitsGenerator();

  String? _generatedFruit;
  Uint8List? _fruitImage;
  bool _isLoading = false;
  bool _hasError = false;

  Future<void> _generateFruitAndSpeak(String letter) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _fruitImage = null;
    });

    try {
      // Get the fruit name based on the selected alphabet
      String fruit = await _fruitsGenerator.getFruitName(letter);
      setState(() {
        _generatedFruit = fruit;
      });

      // Translate the fruit name to English
      String translatedFruit = await _fruitsGenerator.translateToEnglish(fruit);

      // Use Text-to-Speech to pronounce the fruit name in Arabic
      final Uint8List? audioData =
          await _speechModel.speakText(fruit) as Uint8List?;
      if (audioData != null) {
        await _audioPlayer.play(BytesSource(audioData));
      } else {
        print("Audio generation failed.");
      }

      // Generate fruit image with safety check
      final imageResult = await generateImageFromPrompt(translatedFruit);
      if (imageResult['status'] == 'success' &&
          imageResult['imageUrl'] != null) {
        setState(() {
          _fruitImage = base64Decode(imageResult['imageUrl'].split(',')[1]);
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        print(imageResult['message']);
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print("Error generating fruit or audio: $e");
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
          color: Colors.blue.shade300,
          image: const DecorationImage(
            image: AssetImage('lib/assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                    width: 100,
                  ),
                ),

                const SizedBox(height: 20),

                // Display generated fruit name and image
                if (_generatedFruit != null)
                  Column(
                    children: [
                      Text(
                        _generatedFruit!,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : _hasError
                              ? const Text('Image not available',
                                  style: TextStyle(color: Colors.red))
                              : _fruitImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.memory(
                                        _fruitImage!,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                    ],
                  ),

                const SizedBox(height: 20),

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
                                onTap: () => _generateFruitAndSpeak(letter),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade300,
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
          ],
        ),
      ),
    );
  }
}

class FruitsGenerator {
  final String apiKey = dotenv.env['API_KEY']!;
  final String tokenUrl = 'https://iam.cloud.ibm.com/identity/token';
  final String generateUrl =
      'https://eu-de.ml.cloud.ibm.com/ml/v1/text/generation?version=2023-05-29';

  Future<String> getIbMToken() async {
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
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

  Future<String> getFruitName(String arabicLetter) async {
    final token = await getIbMToken();

    final body = {
      "input": """
Input: حرف عربي
Output: اسم فاكهة يبدأ بالحرف المدخل

Input: ت
Output: تفاح

Input: $arabicLetter
Output:""",
      "parameters": {
        "decoding_method": "greedy",
        "max_new_tokens": 200,
        "stop_sequences": ["\n"],
        "repetition_penalty": 1,
      },
      "model_id": "sdaia/allam-1-13b-instruct",
      "project_id": "10ee99ea-e10e-49f6-8126-1ac689449710",
    };

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer $token",
    };

    final response = await http.post(
      Uri.parse(generateUrl),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      String fruitName = data['results'][0]['generated_text'];
      return fruitName.trim();
    } else {
      throw Exception('Failed to generate fruit name: ${response.body}');
    }
  }

  Future<String> translateToEnglish(String arabicText) async {
    const apiUrl =
        "https://api-inference.huggingface.co/models/Helsinki-NLP/opus-mt-ar-en";
    const apiKey =
        "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"; // Replace with your actual API key

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: json.encode({"inputs": arabicText}),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result[0]['translation_text'];
    } else {
      throw Exception("Failed to translate text");
    }
  }
}
