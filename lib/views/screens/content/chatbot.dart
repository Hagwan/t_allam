import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  bool _isLoading = false;

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add({"role": "user", "content": message});
      _isLoading = true;
    });

    final response = await getChatbotResponse(message);

    setState(() {
      messages.add({"role": "bot", "content": response});
      _isLoading = false;
    });
  }

  Future<String> getChatbotResponse(String message) async {
    final apiKey = dotenv.env['API_KEY']!;
    final url =
        "https://eu-de.ml.cloud.ibm.com/ml/v1/text/generation?version=2023-05-29";
    final token = await getIbMToken(apiKey);

    final body = {
      "input": """<s> [INST]
$message

<<SYS>>
أجب فقط من هذا الكتاب، وهو من منهج اللغة العربية في السعودية للصف الرابع، الفصل الأول، بلغة مناسبة لعمر 10 سنوات.
تصرّف كمعلم للغة العربية.
<</SYS>>""",
      "parameters": {
        "decoding_method": "greedy",
        "max_new_tokens": 900,
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
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return data['results'][0]['generated_text'];
    } else {
      throw Exception('Failed to get response: ${response.body}');
    }
  }

  Future<String> getIbMToken(String apiKey) async {
    final tokenUrl = 'https://iam.cloud.ibm.com/identity/token';

    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'urn:ibm:params:oauth:grant-type:apikey',
        'apikey': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final resFormat = json.decode(response.body);
      return resFormat['access_token'];
    } else {
      throw Exception('Error: ${response.statusCode}\n${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("لغتي جي بي تي", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/background.png', // Path to your background image
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - index - 1];
                    bool isUser = message['role'] == 'user';
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isUser) ...[
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                                'lib/assets/icons/Allam_chat.png'), // Replace with actual path
                          ),
                          const SizedBox(width: 8),
                        ],
                        Column(
                          crossAxisAlignment: isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? const Color(0xFF8C68CD)
                                    : const Color(0xFFB996F9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                message['content']!,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        if (isUser) ...[
                          const SizedBox(width: 8),
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                                'lib/assets/images/Allam_head.png'), // Replace with actual path
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final message = _controller.text.trim();
                        if (message.isNotEmpty) {
                          sendMessage(message);
                          _controller.clear();
                        }
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        textDirection: TextDirection.rtl,
                        decoration: const InputDecoration(
                          hintText: "اكتب رسالتك هنا...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
