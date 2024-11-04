import 'package:flutter/material.dart';
import 'tashkeel_details.dart';

class TashkeelScreen extends StatelessWidget {
  const TashkeelScreen({super.key});

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
                MaterialPageRoute(builder: (context) => const TashkeelPage()),
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
class TashkeelPage extends StatelessWidget {
  const TashkeelPage({super.key});

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
                    '2',
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
                'مرحبا في صفحة التشكيل !',
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
                  'أسمي علام وسأساعدك في تعلم التشكيل بالحروف العربية',
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
                          builder: (context) => const tashkeelGroupsScreen()),
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

// Screen 2: Letter Groups
class tashkeelGroupsScreen extends StatelessWidget {
  const tashkeelGroupsScreen({super.key});

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
                    '2',
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
                    _buildLetterGroup(context, ['أُ', 'أِ', 'أَ'], 'Group 1'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['بُ', 'بِ', 'بَ'], 'Group 2'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['تُ', 'تِ', 'تَ'], 'Group 3'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ثُ', 'ثِ', 'ثَ'], 'Group 4'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['جُ', 'جِ', 'جَ'], 'Group 5'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['حُ', 'حِ', 'حَ'], 'Group 6'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['خُ', 'خِ', 'خَ'], 'Group 7'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['دُ', 'دِ', 'دَ'], 'Group 8'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ذُ', 'ذِ', 'ذَ'], 'Group 9'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['رُ', 'رِ', 'رَ'], 'Group 10'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['زُ', 'زِ', 'زَ'], 'Group 11'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['سُ', 'سِ', 'سَ'], 'Group 12'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['شُ', 'شِ', 'شَ'], 'Group 13'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['صُ', 'صِ', 'صَ'], 'Group 14'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ضُ', 'ضِ', 'ضَ'], 'Group 15'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['طُ', 'طِ', 'طَ'], 'Group 16'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['ظُ', 'ظِ', 'ظَ'], 'Group 17'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['عُ', 'عِ', 'عَ'], 'Group 18'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['غُ', 'غِ', 'غَ'], 'Group 19'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['فُ', 'فِ', 'فَ'], 'Group 20'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['قُ', 'قِ', 'قَ'], 'Group 21'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['كُ', 'كِ', 'كَ'], 'Group 22'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['لُ', 'لِ', 'لَ'], 'Group 23'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['مُ', 'مِ', 'مَ'], 'Group 24'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['نُ', 'نِ', 'نَ'], 'Group 25'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['هُ', 'هِ', 'هَ'], 'Group 26'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['وُ', 'وِ', 'وَ'], 'Group 27'),
                    const SizedBox(height: 30),
                    _buildLetterGroup(context, ['يُ', 'يِ', 'يَ'], 'Group 28'),
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
              builder: (context) => tashkeelDetailScreen(
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
