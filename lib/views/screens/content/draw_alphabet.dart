import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';

class DrawAphabet extends StatefulWidget {
  const DrawAphabet({Key? key}) : super(key: key);

  @override
  State<DrawAphabet> createState() => _DrawAphabetState();
}

class _DrawAphabetState extends State<DrawAphabet> {
  final ImagePainterController _controller = ImagePainterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("أرسم الحروف", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Top container with character image and prompt
          Container(
            color: Colors.purple.shade100,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'lib/assets/images/Allam_head.png'), // Replace with actual path
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Draw and complete this word 'أين'?", // Example prompt
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Image Painter (Drawing functionality)
          Expanded(
            child: ImagePainter.asset(
              "lib/assets/images/noon.png", // Replace with actual asset path
              controller: _controller,
              scalable: true,
              textDelegate: TextDelegate(),
            ),
          ),
        ],
      ),
    );
  }
}
