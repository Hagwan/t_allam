import 'package:flutter/material.dart';
import 'stories_page.dart';

class StoriesTopicScreen extends StatelessWidget {
  const StoriesTopicScreen({super.key});

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
                        'اختر القصة التي تريد الاستماع إليها',
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
                    'القصص السحرية',
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
                      title: 'القصة السحرية  ',
                      backgroundColor: const Color(0xFFFF6667),
                      imagePath:
                          'lib/assets/images/stories.png', // Replace with the actual image path
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                StoriesScreen(title: 'القصة السحرية'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSectionCard(
                      context,
                      title: 'قصة مملكة الحيوانات',
                      backgroundColor: const Color(0xFFFF6667),
                      imagePath:
                          'lib/assets/images/animals.png', // Replace with the actual image path
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                StoriesScreen(title: 'قصة مملكة الحيوانات '),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSectionCard(
                      context,
                      title: 'قصة الأبطال',
                      backgroundColor: const Color(0xFFFF6667),
                      imagePath:
                          'lib/assets/images/heros.png', // Replace with the actual image path
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => StoriesScreen(title: 'قصة الأبطال'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildSectionCard(
                      context,
                      title: 'قصة الأميرات',
                      backgroundColor: const Color(0xFFFF6667),
                      imagePath:
                          'lib/assets/images/princes.png', // Replace with the actual image path
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                StoriesScreen(title: 'قصة الأميرات'),
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
        height: 180,
        width: 300,
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
