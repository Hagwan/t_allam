import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../models/image_generator_model.dart';

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
      _imageUrl = null;
    });

    bool isSafe = await isPromptSafeForKids(prompt);
    if (!isSafe) {
      setState(() {
        _status =
            'This prompt is not appropriate for kids. Please try a different one!';
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
        title: Text('انشاء الصور', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the character image at the top
              Image.asset(
                'lib/assets/images/Half_Allam.png', // replace with the actual image asset path
                height: 150,
              ),
              // Display the generated image or placeholder
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.memory(
                          base64Decode(_imageUrl!.split(',')[1]),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.grey.shade400,
                          size: 80,
                        ),
                      ),
              ),

              SizedBox(height: 20),

              // Text field for prompt input
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  hintText: ' اكتب النص هنا...',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),

              SizedBox(height: 20),

              // Button to generate image
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: const Color.fromARGB(255, 39, 92, 176),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    
                  ),
                ),
                label: Text('ابدأ', style: TextStyle(color: Colors.white)),
                icon: Icon(Icons.switch_access_shortcut_rounded,
                    color: Colors.white),
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
              ),

              SizedBox(height: 20),

              // Status message
              if (_status.isNotEmpty)
                Text(
                  _status,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
