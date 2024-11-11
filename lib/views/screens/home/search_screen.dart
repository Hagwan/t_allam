import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/views/screens/content/image_generation.dart';
import 'package:t_allam/views/screens/content/chatbot.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String characterImage =
      'lib/assets/images/Allam.png'; // Define characterImage
  final _prefs =
      SharedPreferences.getInstance(); // Instance of SharedPreferences
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Instance of Firestore

  bool isLughatiGPTEnabled = true;
  bool isObjectDetectionEnabled = true;
  bool isImageGenerationEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load values on initialization
  }

  void _loadPreferences() async {
    final prefs = await _prefs;
    isLughatiGPTEnabled = prefs.getBool('isLughatiGPTEnabled') ?? true;
    isObjectDetectionEnabled =
        prefs.getBool('isObjectDetectionEnabled') ?? true;
    isImageGenerationEnabled =
        prefs.getBool('isImageGenerationEnabled') ?? true;
  }

  void _openRealtimeObjDetectionApp() async {
    const url = 'realtimeobj://open'; // Custom URL scheme for the second app
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch the other app.');
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              const SizedBox(height: 30),
              //if charcter from firestore = Alam then show this image lib/assets/images/Allam.png
              Image.asset(
                characterImage,
                width: 130,
              ),
              const SizedBox(height: 40),

              // Feature Buttons Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (isObjectDetectionEnabled)
                      _buildFeatureButton(
                        icon: Icons.camera_alt_rounded,
                        label: 'إيش هذا؟',
                        gradientColors: const [
                          Color(0xFFBE9AFF),
                          Color(0xFF8C68CD),
                        ],
                        onTap: _openRealtimeObjDetectionApp,
                      ),
                    const SizedBox(width: 20),
                    if (isImageGenerationEnabled)
                      _buildFeatureButton(
                        icon: Icons.add_photo_alternate_rounded,
                        label: 'اصنع صورة!',
                        gradientColors: const [
                          Color(0xFFBE9AFF),
                          Color(0xFF8C68CD),
                        ],
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ImageGenerator(),
                          ));
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              if (isLughatiGPTEnabled)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChatScreen(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFBE9AFF),
                            Color(0xFF8C68CD),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تحدث مع المعلم ذكي',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.chat, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String label,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 100),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
