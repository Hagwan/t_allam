import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final String name;
  final double size;
  final List<Color> gradientColors;
  final bool selected;

  const MyIcon({
    super.key,
    required this.name,
    required this.size,
    required this.gradientColors,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: selected
              ? [
                  const Color(0xFF8C68CD),
                  const Color(0xFFCCB0FF)
                ] // Purple gradient when selected
              : gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(bounds);
      },
      child: ImageIcon(
        AssetImage('lib/assets/icons/$name.png'),
        size: size,
        color: Colors.white, // This color will be masked by the gradient
      ),
    );
  }
}
