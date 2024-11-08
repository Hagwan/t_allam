import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    final url = Uri.parse('http://10.10.27.113:8547/chatbot/');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = json.encode({'query': message});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Decode the response with utf8 to handle Arabic characters
      final data = json.decode(utf8.decode(response.bodyBytes));
      return data['response'];
    } else {
      throw Exception('Failed to fetch response from chatbot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text("لغتي جي بي تي", style: TextStyle(color: Colors.black)),
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
                      mainAxisAlignment: isUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
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
