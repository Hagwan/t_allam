import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'filtering.dart'; // Import the filtering function

class ImageGenerator extends StatefulWidget {
  @override
  _ImageGeneratorState createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  final TextEditingController _controller = TextEditingController();
  String? _imageUrl;
  String _status = '';

  Future<void> _generateImage(String prompt) async {
    setState(() {
      _status = 'Checking prompt for appropriateness...';
      _imageUrl = null; // Reset the image
    });

    // Check if the prompt is safe for kids
    bool isSafe = await isPromptSafeForKids(prompt);
    if (!isSafe) {
      setState(() {
        _status = 'This prompt is not appropriate for kids. Please try a different one!';
      });
      return;
    }

    setState(() {
      _status = 'Generating image...';
    });

    const String apiUrl =
        "https://api-inference.huggingface.co/models/black-forest-labs/FLUX.1-schnell";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer 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", // Replace with your Hugging Face API key
          "Content-Type": "application/json",
        },
        body: jsonEncode({"inputs": prompt}),
      );

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes; // Read the response bytes
        setState(() {
          _imageUrl = 'data:image/png;base64,' + base64Encode(bytes); // Encode bytes as base64
          _status = 'Image generated successfully!';
        });
      } else {
        setState(() {
          _status = 'Error: Failed to generate image.';
        });
      }
    } catch (error) {
      setState(() {
        _status = 'An error occurred: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Generator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter a prompt to generate an image:',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Type your prompt here...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
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
                child: Text('Generate Image'),
              ),
              SizedBox(height: 20),
              if (_status.isNotEmpty) Text(_status),
              if (_imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.memory(base64Decode(_imageUrl!.split(',')[1])),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
