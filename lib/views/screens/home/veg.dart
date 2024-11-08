import 'package:flutter/material.dart';
import 'veg_details.dart';

class VegPage extends StatelessWidget {
  const VegPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade300, // Set the yellow background color
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
                'مرحبا في صفحة الفواكه !',
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
                  ' مرحبا بك في واحة العلم والمعرفوالمعرفة حيث سنتعلم الكثير عن الفواكه  ',
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
                      MaterialPageRoute(builder: (context) => VegScreen()),
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

class VegScreen extends StatelessWidget {
  const VegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
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
                    _buildFruitsGroup(
                        context, ['ح', 'ج', 'ث', 'ت', 'ب', 'أ'], 'Group 1'),
                    const SizedBox(height: 30),
                    _buildFruitsGroup(
                        context, ['س', 'ز', 'ر', 'ذ', 'د', 'خ'], 'Group 2'),
                    const SizedBox(height: 30),
                    _buildFruitsGroup(
                        context, ['ط', 'ظ', 'ع', 'ش', 'ص', 'ض'], 'Group 3'),
                    const SizedBox(height: 30),
                    _buildFruitsGroup(
                        context, ['ك', 'ل', 'م', 'غ', 'ف', 'ق'], 'Group 4'),
                    const SizedBox(height: 30),
                    _buildFruitsGroup(context,
                        ['ي', 'ن', 'ه', 'و', 'ك', 'ل', 'م'], 'Group 5'),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFruitsGroup(
      BuildContext context, List<String> letters, String groupName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VegDeatilsScreen(
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
