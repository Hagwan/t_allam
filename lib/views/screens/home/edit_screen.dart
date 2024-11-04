import 'package:flutter/material.dart';
import 'package:t_allam/views/screens/content/draw_objects.dart';
import '../content/draw_alphabet.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Character Image
            Image.asset(
              'lib/assets/images/Allam.png', // replace with the actual image asset path
              width: 130,
            ),
            const SizedBox(height: 40),
            // Object Detection and Image Generation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFeatureButton(
                    icon: Icons.data_object,
                    label: ' ارسم الاشياء',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DrawObject(),
                      )); // I
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.draw_rounded,
                    label: 'اكتب الحروف ',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DrawAlphabet(),
                      )); // Image Generation action
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Chat with LughatiGPT Button
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFBE9AFF), // Purple color
              Color(0xFF8C68CD), // Light purple color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 100),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
