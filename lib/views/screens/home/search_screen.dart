import 'package:flutter/material.dart';
import '/views/screens/content/image_generation.dart';
import 'package:t_allam/views/screens/content/chatbot.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Directionality(
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
                      icon: Icons.camera_alt_rounded,
                      label: 'كاشف الأجسام',
                      gradientColors: [
                        const Color(0xFFBE9AFF), // Purple color
                        const Color(0xFF8C68CD),
                      ],
                      onTap: () {},
                    ),
                    const SizedBox(width: 20),
                    _buildFeatureButton(
                      icon: Icons.add_photo_alternate_rounded,
                      label: 'إنشاء الصور',
                      gradientColors: [
                        const Color(0xFFBE9AFF), // Purple color
                        const Color(0xFF8C68CD),
                      ],
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ImageGenerator(),
                        ));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Chat with LughatiGPT Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFBE9AFF), // Purple color
                          Color(0xFF8C68CD),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تحدث مع لغتي جي بي تي',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.chat, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
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
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
