import 'package:flutter/material.dart';
import 'edit_screen.dart';
import 'family_screen.dart';
import 'search_screen.dart';
import '../content/stt_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeContent(), // Default Home screen content
    const SearchScreen(),
    const EditScreen(),
    const FamilyScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.stars_outlined, color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_pin_rounded, color: Colors.white),
            onPressed: () {
              // Navigate to Profile Page or handle profile action
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Color(0xFF8E24AA), // Purple color
                Color(0xFFBA68C8), // Light purple color
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade200,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.menu_book_rounded, color: Colors.grey, size: 30),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.search_rounded, color: Colors.grey, size: 30),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: const Icon(Icons.mode_edit_outlined, color: Colors.grey, size: 30),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: const Icon(Icons.family_restroom_outlined, color: Colors.grey, size: 30),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildGroupCard(
                  context,
                  gradientColors: [
                    Colors.orange.shade300,
                    Colors.orange.shade500,
                  ],
                  title: 'المجموعة 1: المكتشفون',
                ),
                _buildGroupCard(
                  context,
                  gradientColors: [
                    Colors.blue.shade300,
                    Colors.blue.shade500,
                  ],
                  title: 'المجموعة 2: المستكشفون',
                ),
                _buildGroupCard(
                  context,
                  gradientColors: [
                    Colors.red.shade300,
                    Colors.red.shade500,
                  ],
                  title: 'المجموعة 3: المبدعون',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context,
      {required List<Color> gradientColors, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SpeechToTextPage()),
          );
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: Icon(Icons.menu_book_rounded,
                    color: Colors.white, size: 30),
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
