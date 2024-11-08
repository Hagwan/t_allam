import 'package:flutter/material.dart';
import 'kid_profile.dart';

class ParentalProfile extends StatefulWidget {
  const ParentalProfile({Key? key}) : super(key: key);

  @override
  _ParentalProfileState createState() => _ParentalProfileState();
}

class _ParentalProfileState extends State<ParentalProfile> {
  final List<Color> colors = [const Color(0xFFBE9AFF), const Color(0xFF8C68CD)];
  bool isToggled = true;

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
                    _monitoringSection(),
                    const SizedBox(height: 16),
                    _controlsSection(),
                    const SizedBox(height: 16),
                    _supportSection(),
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
                      if (!isToggled) {
                        Navigator.pop(context);
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
                'lib/assets/images/family.png'), // Replace with the parent/family image
          ),
          const SizedBox(height: 8),
          const Text(
            'Parent',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _monitoringSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Monitoring', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _monitoringCard('Time Spent', '05 Hours')),
            const SizedBox(width: 8),
            Expanded(child: _monitoringCard('Content Safety', 'Safe')),
            const SizedBox(width: 8),
            Expanded(child: _monitoringCard('Performance', 'Stats')),
          ],
        ),
      ],
    );
  }

  Widget _monitoringCard(String title, String value) {
    return _gradientContainer(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _controlsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Controls', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        _toggleControl('Lughati GPT'),
        const SizedBox(height: 8),
        _toggleControl('Object Detection'),
        const SizedBox(height: 8),
        _toggleControl('Image Generation'),
      ],
    );
  }

  Widget _toggleControl(String title) {
    return _gradientContainer(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Switch(
            value: true,
            onChanged: (bool value) {},
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _supportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        _supportOption('FAQ'),
        const SizedBox(height: 8),
        _supportOption('Support'),
        const SizedBox(height: 8),
        const Text('Ta’allam V.0.1',
            style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _supportOption(String title) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        title,
        style: const TextStyle(color: Colors.blue, fontSize: 16),
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
