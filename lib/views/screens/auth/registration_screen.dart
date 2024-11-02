import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_allam/views/screens/home/home_screen.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NameInputScreen();
  }
}

class NameInputScreen extends StatefulWidget {
  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final _nameController = TextEditingController();

  void _next() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AgeInputScreen(name: _nameController.text),
    ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return 
 Scaffold(
      appBar: AppBar(
        title:  
 Text('مرحبًا بك! ما اسمك؟', style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: const Color(0xFF761FB0), // Purple color
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content   
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: ' ما اسمك؟',
                hintText: 'خالد',
              ),
              textAlign: TextAlign.center, // Center the text
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _next,
              child: Text('التالي', style: TextStyle(color: Colors.white, fontSize: 20))
              ,style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      backgroundColor: const Color(0xFF761FB0), // Purple color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgeInputScreen extends StatefulWidget {
  final String name;

  AgeInputScreen({required this.name});

  @override
  _AgeInputScreenState createState() => _AgeInputScreenState();
}

class _AgeInputScreenState extends State<AgeInputScreen> {
  final _ageController = TextEditingController();

  void _next() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CharacterSelectionScreen(name: widget.name, age: _ageController.text),
    ));
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('كم عمرك؟')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'كم عمرك؟'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _next,
              child: Text('التالي'),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterSelectionScreen extends StatefulWidget {
  final String name;
  final String age;

  CharacterSelectionScreen({required this.name, required this.age});

  @override
  _CharacterSelectionScreenState createState() => _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  String _selectedCharacter = "Alam"; // Default character selection

  Future<void> _submitDetails() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      // Save additional details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'age': widget.age,
        'name': widget.name,
        'character': _selectedCharacter,
        'email': FirebaseAuth.instance.currentUser?.email,
      }, SetOptions(merge: true));

      // Navigate to the next screen or home
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اختر الشخصية')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CharacterSelectionButton(
                  character: "Alam",
                  isSelected: _selectedCharacter == "Alam",
                  onTap: () => setState(() => _selectedCharacter = "Alam"),
                ),
                CharacterSelectionButton(
                  character: "Ula",
                  isSelected: _selectedCharacter == "Ula",
                  onTap: () => setState(() => _selectedCharacter = "Ula"),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitDetails,
              child: Text('تأكيد'),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterSelectionButton extends StatelessWidget {
  final String character;
  final bool isSelected;
  final VoidCallback onTap;

  CharacterSelectionButton({
    required this.character,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            'lib/assets/images/$character.png', // Use correct image paths
            width: 100,
            height: 100,
          ),
          Text(character),
          if (isSelected) Icon(Icons.check, color: Colors.green),
        ],
      ),
    );
  }
}
