// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:audioplayers/audioplayers.dart';

// class ElevenlabsSpeech extends StatefulWidget {
//   @override
//   _ElevenlabsSpeechState createState() => _ElevenlabsSpeechState();
// }

// class _ElevenlabsSpeechState extends State<ElevenlabsSpeech> {
//   int currentIndex = 0;
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   final List<List<String>> alphabetButtons = [
//     ["ا", "ا", "ا", "ا"],
//     ["السلام عليكم انا علّام ", "السلام عليكم انا علّام ", "السلام عليكم انا علّام ", " السلام عليكم انا علّام "],
//     ["ياء", "ياء", "ياء", "ياء"],
//   ];

//   // Your ElevenLabs API key
//   final String apiKey = 'sk_c222312dbfe64eb7e59c044ac6855eb9c1ea228c27d91e5c';
//   final String voiceId = '9BWtsMINqrJLrRacOk9x'; // Replace with an actual voice ID

//   void _goToNext() {
//     if (currentIndex < alphabetButtons.length - 1) {
//       setState(() {
//         currentIndex++;
//       });
//     }
//   }

//   void _goToPrevious() {
//     if (currentIndex > 0) {
//       setState(() {
//         currentIndex--;
//       });
//     }
//   }

//   Future<void> speakAlphabet(String alphabet) async {
//     final url = Uri.parse('https://api.elevenlabs.io/v1/text-to-speech/$voiceId');
    
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'xi-api-key': apiKey,
//       },
//       body: json.encode({
//         'text': alphabet,  // The text you want to convert to speech
//         "model_id": "eleven_multilingual_v2",
//         'voice_settings': {
//           'stability': 0.75,
//           'similarity_boost': 0.75,
//         }
//       }),
//     );

//     if (response.statusCode == 200) {
//       final audioBytes = response.bodyBytes;

//       // Play the audio using audioplayers package
//       await _audioPlayer.play(BytesSource(audioBytes));
//     } else {
//       print('Failed to generate speech: ${response.statusCode}');
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();  // Clean up the audio player
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: _goToPrevious,
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {
//               // Handle menu action
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: Center(
//                 child: Image.asset(
//                   'lib/assets/images/character.png', // Replace with your character image path
//                   height: 150,
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//             Expanded(
//               child: GridView.builder(
//                 shrinkWrap: true,

//                 itemCount: 4,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 2.0,
//                   crossAxisSpacing: 16.0,
//                   mainAxisSpacing: 16.0,
//                 ),
//                 itemBuilder: (context, index) {
//                   return ElevatedButton(
//                     onPressed: () async {
//                       // Call ElevenLabs TTS when the button is pressed
//                       await speakAlphabet(alphabetButtons[currentIndex][index]);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green[300],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: Text(
//                       alphabetButtons[currentIndex][index],
//                       style: TextStyle(
//                         fontSize: 32,
//                         color: Colors.white,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   if (currentIndex > 0)
//                     TextButton(
//                       onPressed: _goToPrevious,
//                       child: Text(
//                         'الرجوع',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   TextButton(
//                     onPressed: _goToNext,
//                     child: Text(
//                       currentIndex == alphabetButtons.length - 1
//                           ? 'الرجوع'
//                           : 'التالي',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
