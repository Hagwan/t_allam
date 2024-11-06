import 'package:flutter/material.dart';
import 'stories.dart';

class CreatorsScreen extends StatelessWidget {
  const CreatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6667),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Top section with character and welcome message
          Container(
            color: const Color(0xFFFF6667),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Row(
              children: [
                Image(image: AssetImage('lib/assets/images/Half_Allam.png')),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'اهلا، أحمد',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'اكمل المراحل،  لتكسب المزيد  من النقاط',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Main stage card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                    height: 15,
                    indent: 120,
                    endIndent: 120,
                    thickness: 4,
                    color: Colors.grey),
                Text(
                  'المرحلة الثالثة',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Scrollable section cards
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildSectionCard(
                    context,
                    title: 'القصص السحرية ',
                    backgroundColor: const Color(0xFFFF6667),
                    imagePath:
                        'lib/assets/images/stories.png', // Replace with the actual image path
                    onTap: () {
                      // Navigate to the letters page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const StoriesPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    context,
                    title: 'قصة الحيوانات',
                    backgroundColor: const Color(0xFFFF6667),
                    imagePath:
                        'lib/assets/images/animals.png', // Replace with the actual image path
                    onTap: () {
                      // Navigate to the formation page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const FormationPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required Color backgroundColor,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180, // Set uniform height for each card
        width: 300, // Make cards full width
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder page for LettersPage

// Placeholder page for FormationPage
class FormationPage extends StatelessWidget {
  const FormationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formation'),
      ),
      body: const Center(
        child: Text('Content for Formation Page'),
      ),
    );
  }
}
