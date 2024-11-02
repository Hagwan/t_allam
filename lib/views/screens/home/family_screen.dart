import 'package:flutter/material.dart';
import 'parent_dashboard_screen.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  bool isParentalEnabled = false;

  void _toggleParentalControl(bool value) {
    setState(() {
      isParentalEnabled = value;
    });

    if (value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParentDashboardScreen(),
        ),
      ).then((_) {
        // Reset the switch back after returning from ParentDashboardScreen
        setState(() {
          isParentalEnabled = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top section with profile picture, name, and parental control toggle
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.purple.shade300,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 50), // Placeholder for symmetry
                    const Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                              'lib/assets/images/Allam_head.png'), // Replace with actual asset path
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Allam',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Switch(
                          value: isParentalEnabled,
                          onChanged: _toggleParentalControl,
                          activeColor: Colors.white,
                        ),
                        const Text(
                          'Parental',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Progress statistics
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Progress',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatBox('Rewards', '10', Icons.star, Colors.purple),
                    _buildStatBox('Streak', '3 Days',
                        Icons.local_fire_department, Colors.purple.shade300),
                    _buildStatBox(
                        'Lesson', '1', Icons.school, Colors.purple.shade300),
                  ],
                ),
                const SizedBox(height: 20),

                // Progress Bars
                _buildProgressSection(
                    'Discoverers', Colors.orange.shade300, 0.8),
                const SizedBox(height: 20),
                _buildProgressSection('Explorers', Colors.blue.shade300, 0.8),
                const SizedBox(height: 20),
                _buildProgressSection('Creators', Colors.red.shade300, 0.8),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
    );
  }

  // Widget for statistics box (rewards, streak, lesson)
  Widget _buildStatBox(String title, String value, IconData icon, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Widget for each progress section (Discoverers, Explorers, Creators)
  Widget _buildProgressSection(String title, Color color, double progress) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                width: 150,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 150 * progress,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
