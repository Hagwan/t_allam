import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';

class WebExample extends StatefulWidget {
  const WebExample({Key? key}) : super(key: key);

  @override
  State<WebExample> createState() => _WebExampleState();
}

class _WebExampleState extends State<WebExample> {
  final ImagePainterController _controller = ImagePainterController();
    int _selectedIndex = 0;

void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Page", style: TextStyle(color: Colors.black)),
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
                  radius: 30,
                  backgroundImage: AssetImage(
                      'lib/assets/images/character.png'), // Replace with actual path
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
              "lib/assets/images/noon.png", // Replace with actual asset path
              controller: _controller,
              scalable: true,
              textDelegate: TextDelegate(),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade200,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.menu_book_rounded, color: Colors.grey, size: 30),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.search_rounded, color: Colors.grey, size: 30),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: const Icon(Icons.mode_edit_outlined, color: Colors.grey, size: 30),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: const Icon(Icons.family_restroom_outlined, color: Colors.grey, size: 30),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
