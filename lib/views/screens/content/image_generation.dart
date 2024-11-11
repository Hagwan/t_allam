import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../models/image_generator_model.dart';
import 'package:http/http.dart' as http;

class ImageGenerator extends StatefulWidget {
  @override
  _ImageGeneratorState createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  final TextEditingController _controller = TextEditingController();
  String? _imageUrl;
  String _status = '';

  Future<bool> isPromptSafeForKids(String prompt) async {
    return true; // Replace with actual safety check logic if needed
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

  Future<void> _generateImage(String prompt) async {
    setState(() {
      _status = 'Checking prompt for appropriateness...';
      _imageUrl = null;
    });

    bool isSafe = await isPromptSafeForKids(prompt);
    if (!isSafe) {
      setState(() {
        _status = 'هذا النص غير مناسب لك. الرجاء تجربة نص آخر!';
      });
      return;
    }

    setState(() {
      _status = 'Translating prompt...';
    });

    try {
      String translatedPrompt = await translateToEnglish(prompt);

      setState(() {
        _status = 'Generating image...';
      });

      final result = await generateImageFromPrompt(translatedPrompt);
      setState(() {
        if (result['status'] == 'success') {
          _imageUrl = result['imageUrl'];
          _status = 'Image generated successfully!';
        } else {
          _status = result['message'];
        }
      });
    } catch (e) {
      setState(() {
        _status = 'Error in translation or image generation: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('انشاء الصور', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'lib/assets/images/Half_Allam.png',
                  height: 150,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(
                            base64Decode(_imageUrl!.split(',')[1]),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.grey.shade400,
                            size: 80,
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                TextField(
                  textDirection: TextDirection.rtl,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: ' اكتب النص هنا...',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 39, 92, 176),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  label:
                      const Text('ابدأ', style: TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.switch_access_shortcut_rounded,
                      color: Colors.white),
                  onPressed: () {
                    final prompt = _controller.text;
                    if (prompt.isNotEmpty) {
                      _generateImage(prompt);
                    } else {
                      setState(() {
                        _status = 'Please enter a prompt.';
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                if (_status.isNotEmpty)
                  Text(
                    _status,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
