import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';

class DrawObjects extends StatefulWidget {
  const DrawObjects({Key? key}) : super(key: key);

  @override
  State<DrawObjects> createState() => _DrawObjectsState();
}

class _DrawObjectsState extends State<DrawObjects> {
  final ImagePainterController _controller = ImagePainterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("أرسم الأشكال ", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Top container with character image and prompt
          Container(
            color: Colors.purple.shade100,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'lib/assets/images/Allam_head.png'), // Replace with actual path
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
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
              "lib/assets/images/Ula.png", // Replace with actual asset path
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
