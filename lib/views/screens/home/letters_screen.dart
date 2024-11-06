import 'package:flutter/material.dart';
import 'letter_detail_screen.dart';

class LettersScreen extends StatelessWidget {
  const LettersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade300,
        title: const Text('Discoverers'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orange.shade300, // Set the yellow background color
          image: const DecorationImage(
            image: AssetImage(
                'lib/assets/images/background.png'), // Set background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const letterPage()),
              );
            },
            child: const Text('Go to Letters Page'),
          ),
        ),
      ),
    );
  }
}

// Screen 1: Intro to Letters
class letterPage extends StatelessWidget {
  const letterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orange.shade300, // Set the yellow background color
          image: const DecorationImage(
            image: AssetImage(
                'lib/assets/images/background.png'), // Set background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
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
              const Text(
                textDirection: TextDirection.rtl,
                'مرحبا في صفحة الحروف !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'lib/assets/images/Allam.png', // Replace with actual image path
                  width: 140,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  textDirection: TextDirection.rtl,
                  ' أسمي علام وسأساعدك في تعلم الحروف العربية ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const letterpages()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class letterpages extends StatelessWidget {
  const letterpages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orange.shade300,
          image: const DecorationImage(
            image: AssetImage('lib/assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
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
              Expanded(
                child: ListView(
                  children: [
                    _buildLetterGroup(context, ['ت', 'ب', 'أ'], 'Group 1'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ح', 'ج', 'ث'], 'Group 2'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ذ', 'د', 'خ'], 'Group 3'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['س', 'ز', 'ر'], 'Group 4'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ش', 'ص', 'ض'], 'Group 5'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ط', 'ظ', 'ع'], 'Group 6'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['غ', 'ف', 'ق'], 'Group 7'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ك', 'ل', 'م'], 'Group 8'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ي', 'ن', 'ه', 'و'], 'Group 9'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLetterGroup(
      BuildContext context, List<String> letters, String groupName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LetterDetailScreen(
                    groupName: groupName,
                    letters: letters,
                  )),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: letters
              .map((letter) => Text(
                    letter,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
