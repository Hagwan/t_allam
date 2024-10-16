import 'dart:convert';
import 'package:http/http.dart' as http;

class VegetableGenerator {
  final String apiKey = 'kpCtfv0ECosknIUz1cUjXml3opp8ja68u5ow12QV84Wc';
  final String tokenUrl = 'https://iam.cloud.ibm.com/identity/token';
  final String generateUrl = 'https://eu-de.ml.cloud.ibm.com/ml/v1/text/generation?version=2023-05-29';

  // Function to get the IBM access token
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

  // Function to get the vegetable name based on the Arabic letter
Future<String> getVegetableName(String arabicLetter) async {
    final token = await getIbMToken(); // Get IBM access token

    // Construct the body with the specific input format
    final body = {
      "input": """
Input: حرف عربي
Output: اسم خضار يبدأ بالحرف المدخل

Input: ج
Output: جزر

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
      "Content-Type": "application/json; charset=utf-8", // Ensure UTF-8 encoding
      "Authorization": "Bearer $token",
    };

    final response = await http.post(
      Uri.parse(generateUrl),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes)); // Decode the response properly
      String vegetableName = data['results'][0]['generated_text'];
      return vegetableName.trim(); // Trim to remove any extra new lines or spaces
    } else {
      throw Exception('Failed to generate vegetable name: ${response.body}');
    }
  }

}
