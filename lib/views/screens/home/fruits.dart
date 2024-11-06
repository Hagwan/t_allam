import 'package:flutter/material.dart';
import 'package:t_allam/views/screens/home/family_page.dart'; // Screen 1: Intro to Letters

class FruitsPage extends StatelessWidget {
  const FruitsPage({super.key});

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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => FamilyLessonPage()),
                    // );
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
