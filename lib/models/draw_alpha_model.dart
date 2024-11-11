import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DrawingInstructionGenerator {
  final String apiKey = dotenv.env['API_KEY']!;
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

  // Function to generate a drawing instruction for a specific Arabic letter
  Future<String> getDrawingInstruction(String arabicLetter) async {
    final token = await getIbMToken(); // Get IBM access token

    // Construct the body with the specific input format for drawing instructions
    final body = {
      "input": """
<s> [INST]<<SYS>>
Generate an instructional question for children to draw a specific Arabic letter. The letter should be presented in the question in Arabic script. Use the following format:

'هل يمكنك رسم الحرف [Letter]؟'
Arabic Prompt: "هل يمكنك رسم الحرف ب؟"
Replace '[Letter]' with the specified Arabic letter

<</SYS>>
 next [/INST] هل يمكنك رسم الحرف $arabicLetter؟
 </s><s> [INST]""",
      "parameters": {
        "decoding_method": "greedy",
        "max_new_tokens": 100,
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
      String drawingInstruction = data['results'][0]['generated_text'];
      return drawingInstruction.trim(); // Trim to remove any extra new lines or spaces
    } else {
      throw Exception('Failed to generate drawing instruction: ${response.body}');
    }
  }
}
