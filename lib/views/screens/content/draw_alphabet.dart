import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:math'; // for generating a random number

class DrawingInstructionGenerator {
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

  Future<String> getNextDrawingPrompt() async {
    final token = await getIbMToken();

    // Generate a random integer to create variability in each request

    final body = {
      "input": """<s> [INST]<<SYS>>
Generate an instructional question for children to draw a specific Arabic letter. The letter should be presented in the question in Arabic script.. Use the following format:

'\\''هل يمكنك رسم الحرف '\\''[Letter]؟
Arabic Prompt: \\"هل يمكنك رسم الحرف ب؟\\"
Replace '\\''[Letter]'\\'' with the specified Arabic letter

<</SYS>>



where [Letter] is replaced by a new Arabic letter each time. <</SYS>>
next [/INST]""",
      "parameters": {
       "decoding_method": "sample",
        "temperature": 0.8, // Adjusts randomness; higher values increase variation
        "top_k": 50,       // Limits selection to the top-k likely choices
        "max_new_tokens": 50,
        "stop_sequences": ["\n"],
        "repetition_penalty": 1.2
      },
      "model_id": "sdaia/allam-1-13b-instruct",
      "project_id": "10ee99ea-e10e-49f6-8126-1ac689449710"
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
      return data['results'][0]['generated_text'].trim();
    } else {
      throw Exception('Failed to generate drawing prompt: ${response.body}');
    }
  }
}

class DrawAlphabet extends StatefulWidget {
  const DrawAlphabet({Key? key}) : super(key: key);

  @override
  State<DrawAlphabet> createState() => _DrawAlphabetState();
}

class _DrawAlphabetState extends State<DrawAlphabet> {
  final ImagePainterController _controller = ImagePainterController();
  final DrawingInstructionGenerator generator = DrawingInstructionGenerator();
  String promptText = "Loading prompt...";

  @override
  void initState() {
    super.initState();
    dotenv.load(fileName: ".env").then((_) {
      _fetchNewPrompt();
    });
  }

  Future<void> _fetchNewPrompt() async {
    setState(() {
      promptText = "Generating prompt...";
    });

    try {
      final newPrompt = await generator.getNextDrawingPrompt();
      setState(() {
        promptText = newPrompt;
      });
    } catch (e) {
      setState(() {
        promptText = "Error generating prompt.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("أرسم الحروف", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.purple.shade100,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'lib/assets/images/Allam_head.png'), // Replace with actual path
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      promptText,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ImagePainter.asset(
              "lib/assets/images/Rectangle.png",
              controller: _controller,
              scalable: true,
              textDelegate: TextDelegate(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _fetchNewPrompt,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade300,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Next',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
