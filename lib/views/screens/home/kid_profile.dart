import 'package:flutter/material.dart';
import 'parentalprofile.dart';

class KidProfile extends StatefulWidget {
  const KidProfile({super.key});

  @override
  State<KidProfile> createState() => _KidProfileState();
}

class _KidProfileState extends State<KidProfile> {
  final List<Color> colors = [const Color(0xFFBE9AFF), const Color(0xFF8C68CD)];
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          ListView(
            children: [
              _header(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _progressSection(),
                    const SizedBox(height: 16),
                    _levelsSection(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return _gradientContainer(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Switch(
                    value: isToggled,
                    onChanged: (value) {
                      setState(() {
                        isToggled = value;
                      });
                      if (isToggled) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ParentalProfile(),
                          ),
                        );
                      }
                    },
                    activeColor: Colors.white,
                    inactiveThumbColor: colors[1],
                  ),
                  Text(
                    isToggled ? "Parental On" : "Parental Off",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
                'lib/assets/images/Allam_head.png'), // Replace with Allam's face image
          ),
          const SizedBox(height: 8),
          const Text(
            'Allam',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _rewards() {
    return _gradientContainer(
      height: 200,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Rewards',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('10',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.bold)),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.star, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tasks(
      {required String task, required int points, String? description}) {
    return _gradientContainer(
      height: 95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$points',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                if (description != null)
                  Text(description,
                      style: const TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Progress', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _rewards()),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  _tasks(task: 'Streak', points: 5, description: 'Days'),
                  const SizedBox(height: 8),
                  _tasks(task: 'Lesson', points: 10),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _levelsSection() {
    return Column(
      children: [
        _progressBar('Discoverers', 80, Colors.orange[200]!),
        const SizedBox(height: 8),
        _progressBar('Explorers', 60, Colors.blue[200]!),
        const SizedBox(height: 8),
        _progressBar('Creators', 40, Colors.red[200]!),
      ],
    );
  }

  Widget _progressBar(String title, int progress, Color color) {
    return _gradientContainer(
      colors: [color, color.withOpacity(0.5)],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: FractionallySizedBox(
                      widthFactor: progress / 100,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('$progress%',
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _gradientContainer(
      {required Widget child,
      List<Color>? colors,
      double? height,
      BorderRadius? borderRadius}) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? this.colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
