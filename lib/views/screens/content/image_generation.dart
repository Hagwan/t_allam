import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../models/image_generator_model.dart'; // Import the model file

class ImageGenerator extends StatefulWidget {
  @override
  _ImageGeneratorState createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  final TextEditingController _controller = TextEditingController();
  String? _imageUrl;
  String _status = '';

  Future<bool> isPromptSafeForKids(String prompt) async {
    // Implement your logic to check if the prompt is safe for kids
    // For now, let's assume all prompts are safe
    return true;
  }

  Future<void> _generateImage(String prompt) async {
    setState(() {
      _status = 'Checking prompt for appropriateness...';
      _imageUrl = null; // Reset the image
    });

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

    final result = await generateImageFromPrompt(prompt);
    setState(() {
      if (result['status'] == 'success') {
        _imageUrl = result['imageUrl'];
        _status = 'Image generated successfully!';
      } else {
        _status = result['message'];
      }
    });
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
