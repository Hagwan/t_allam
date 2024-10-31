import 'package:flutter/material.dart';
import 'package:t_allam/views/screens/home/letters_screen.dart';
// Screen 3: Letter Details
class LetterDetailScreen extends StatelessWidget {
  final String groupName;
  final List<String> letters;

  const LetterDetailScreen({
    Key? key,
    required this.groupName,
    required this.letters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade300,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row with Close and Page Number
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context), // Go back
                ),
                Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Character Image
            Center(
              child: Image.asset(
                'lib/assets/images/Allam.png', // Replace with actual image path
                height: 200,
              ),
            ),

            const SizedBox(height: 20),

            // Letter Group Container
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: letters
                      .map((letter) => _buildLetterIcon(letter))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Navigation Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    // Add functionality for the back button
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up,
                      color: Colors.black, size: 30),
                  onPressed: () {
                    // Add functionality to play the sound of the letters
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    // Add functionality for the forward button
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for individual letter icons
  Widget _buildLetterIcon(String letter) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.yellow.shade700,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        letter,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
