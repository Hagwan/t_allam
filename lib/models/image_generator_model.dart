import 'dart:convert';
import 'package:http/http.dart' as http;

const String imageGenerationApiUrl =
    "https://api-inference.huggingface.co/models/black-forest-labs/FLUX.1-schnell";
const String filteringApiUrl =
    "https://api-inference.huggingface.co/models/unitary/toxic-bert";
const String apiKey = "Bearer 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"; // Replace with your Hugging Face API key

Future<bool> isPromptSafeForKids(String prompt) async {
  try {
    final response = await http.post(
      Uri.parse(filteringApiUrl),
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

Future<Map<String, dynamic>> generateImageFromPrompt(String prompt) async {
  // Check if the prompt is safe before proceeding with image generation
  bool isSafe = await isPromptSafeForKids(prompt);
  if (!isSafe) {
    return {
      'status': 'error',
      'message': 'This prompt is not appropriate for kids. Please try a different one!',
    };
  }

  try {
    final response = await http.post(
      Uri.parse(imageGenerationApiUrl),
      headers: {
        "Authorization": apiKey,
        "Content-Type": "application/json",
      },
      body: jsonEncode({"inputs": prompt}),
    );

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final imageUrl = 'data:image/png;base64,' + base64Encode(bytes);
      return {
        'status': 'success',
        'imageUrl': imageUrl,
      };
    } else {
      return {
        'status': 'error',
        'message': 'Error: Failed to generate image.',
      };
    }
  } catch (error) {
    return {
      'status': 'error',
      'message': 'An error occurred: $error',
    };
  }
}
