import 'package:flutter/material.dart';
import 'package:t_allam/views/screens/home/parentalprofile.dart';
import 'edit_screen.dart';
import 'kid_profile.dart';
import 'search_screen.dart';
import '../content/stt_screen.dart';
import 'discoverers_screen.dart'; // Import the DiscoverersScreen
import 'Explorers.dart';
import 'Creators.dart';
import 'package:t_allam/models/icons.dart';

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
    const KidProfile(),
    const ParentalProfile(),
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
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: MyIcon(
            name: "allam_icon",
            size: 10,
            gradientColors: [
              Color(0xFF898A8D),
              Color(0xFFBEBEBE),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_pin_rounded, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const KidProfile()),
              );
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFBE9AFF),
                Color(0xFF8C68CD),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade200,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: MyIcon(
                name: 'book',
                size: 30,
                gradientColors: const [
                  Color(0xFF898A8D),
                  Color(0xFFBEBEBE),
                ],
                selected: _selectedIndex == 0,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: MyIcon(
                name: 'travel',
                size: 30,
                gradientColors: const [
                  Color(0xFF898A8D),
                  Color(0xFFBEBEBE),
                ],
                selected: _selectedIndex == 1,
              ),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: MyIcon(
                name: 'draw',
                size: 30,
                gradientColors: const [
                  Color(0xFF898A8D),
                  Color(0xFFBEBEBE),
                ],
                selected: _selectedIndex == 2,
              ),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: MyIcon(
                name: 'pprofile',
                size: 30,
                gradientColors: const [
                  Color(0xFF898A8D),
                  Color(0xFFBEBEBE),
                ],
                selected: _selectedIndex == 3,
              ),
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
                const SizedBox(height: 60),
                _buildGroupCard(
                  context,
                  gradientColors: [
                    const Color(0xFFFFDA7E),
                    const Color(0xFFFFCC4D),
                  ],
                  title: ' المكتشفون',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const DiscoverersScreen()),
                  ),
                ),
                const SizedBox(height: 60),
                _buildGroupCard(
                  context,
                  gradientColors: [
                    Colors.blue.shade300,
                    Colors.blue.shade500,
                  ],
                  title: ' المغامرون',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ExplorersScreen()),
                  ),
                ),
                const SizedBox(height: 60),
                _buildGroupCard(
                  context,
                  gradientColors: [
                    Colors.red.shade300,
                    Colors.red.shade500,
                  ],
                  title: ' المبدعون',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CreatorsScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context,
      {required List<Color> gradientColors,
      required String title,
      VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
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
                    shadows: [
                      Shadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
