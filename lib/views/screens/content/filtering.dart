import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;

Future<bool> isPromptSafeForKids(String prompt) async {
  const String apiUrl = "https://api-inference.huggingface.co/models/unitary/toxic-bert";
  const String apiKey = "Bearer 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"; // Replace with your Hugging Face API key

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': apiKey,
        'Content-Type': 'application/json',
      },
      body: json.encode({"inputs": prompt}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> result = json.decode(response.body);
      final double toxicityScore = result[0][0]["score"];

      return toxicityScore <= 0.5; // Return true if safe for kids
    } else {
      return false; // Default to false on API failure
    }
  } catch (error) {
    return false; // Default to false on error
  }
}
