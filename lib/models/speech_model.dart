import 'dart:convert';
import 'package:http/http.dart' as http;

class ArabicAlphabetModel {
  Future<List<int>?> speakText(String text) async {
    final url = Uri.parse('https://api.fish.audio/v1/tts');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 4e833dc7890d4a138201ba0ecd5c9bb5',
      },
      body: json.encode({
        'reference_id': '7861a9c16c20452fa22eb58c3ae4062f',
        'text': text,
        'format': 'mp3',
      }),
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      print('Failed to generate speech: ${response.statusCode}');
      return null;
    }
  }
}

