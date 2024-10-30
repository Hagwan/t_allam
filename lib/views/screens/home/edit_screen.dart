import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Character Image
            Image.asset(
              'lib/assets/images/Allam.png', // replace with the actual image asset path
              height: 250,
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
                      // Object Detection action
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.draw_rounded,
                    label: 'اكتب الحروف ',
                    onTap: () {
                      // Image Generation action
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Chat with LughatiGPT Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
          color: Colors.purple.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
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
