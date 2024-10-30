import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';


class WebExample extends StatefulWidget {
  const WebExample({Key? key}) : super(key: key);

  @override
  State<WebExample> createState() => _WebExampleState();
}

class _WebExampleState extends State<WebExample> {
  final ImagePainterController _controller = ImagePainterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Painter Example"),
        
      ),
      body: ImagePainter.asset(
        "lib/assets/images/noon.png",
        controller: _controller,
        scalable: true,
        textDelegate: TextDelegate(),
      ),
    );
  }
}
