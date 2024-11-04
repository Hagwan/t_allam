// import 'package:flutter/material.dart';

// class RegistrationNameScreen extends StatefulWidget {
//   @override
//   _RegistrationNameScreenState createState() => _RegistrationNameScreenState();
// }

// class _RegistrationNameScreenState extends State<RegistrationNameScreen> {
//   final TextEditingController _ageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             // Handle back button functionality
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Arabic text for "What is your age?"
//             const Text(
//               'كم عمرك؟',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 40),
//             // TextField for age input
//             TextField(
//               controller: _ageController,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 24),
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(vertical: 15),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: const BorderSide(color: Colors.blue),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: const BorderSide(color: Colors.blue),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             // Button for "Next"
//             ElevatedButton(
//               onPressed: () {
//                 // Handle button click
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF761FB0), // Purple button color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//               ),
//               child: const Text(
//                 'التالي',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
