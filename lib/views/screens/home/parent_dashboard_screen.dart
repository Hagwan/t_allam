// import 'package:flutter/material.dart';

// class ParentDashboardScreen extends StatefulWidget {
//   const ParentDashboardScreen({super.key});

//   @override
//   _ParentDashboardScreenState createState() => _ParentDashboardScreenState();
// }

// class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
//   bool isParentalMode = true;

//   void _toggleParentalMode(bool value) {
//     setState(() {
//       isParentalMode = value;
//     });

//     if (!value) {
//       Navigator.pop(context); // Go back to FamilyScreen
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Top Profile Section
//           Container(
//             padding: const EdgeInsets.all(12.0),
//             decoration: BoxDecoration(
//               color: Colors.purple.shade300,
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.grey.shade300,
//                   child:
//                       const Icon(Icons.person, color: Colors.black, size: 40),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Parent',
//                   style: TextStyle(
//                     fontSize: 22,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Parental',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(width: 10),
//                     Switch(
//                       value: isParentalMode,
//                       onChanged: _toggleParentalMode,
//                       activeColor: Colors.white,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Monitoring Section
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Monitoring',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildStatBox('Time Spent', '05', 'Hours', Colors.purple),
//                     _buildStatBox(
//                       'Content Safety',
//                       '',
//                       '',
//                       Colors.purple.shade300,
//                       Icons.check_circle,
//                     ),
//                     _buildStatBox(
//                       'Performance',
//                       '',
//                       '',
//                       Colors.purple.shade300,
//                       Icons.bar_chart,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),

//                 // Controls Section
//                 const Text(
//                   'Controls',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 _buildControlSwitch('Lughati GPT'),
//                 _buildControlSwitch('Object Detection'),
//                 _buildControlSwitch('Image Generation'),
//               ],
//             ),
//           ),

//           const Spacer(),

//           // Support Section
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 5.0),
//             child: Column(
//               children: [
//                 Text(
//                   'Support',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'FAQ',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Ta’allam V.0.1',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget for statistics box (Time Spent, Content Safety, Performance)
//   Widget _buildStatBox(String title, String value, String subtitle, Color color,
//       [IconData? icon]) {
//     return Container(
//       width: 110,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (icon != null)
//             Icon(icon, color: Colors.white, size: 25)
//           else
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 25,
//                 color: Colors.white,
//               ),
//             ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: const TextStyle(color: Colors.white),
//           ),
//           if (subtitle.isNotEmpty)
//             Text(
//               subtitle,
//               style: const TextStyle(color: Colors.white),
//             ),
//         ],
//       ),
//     );
//   }

//   // Widget for each control switch (Lughati GPT, Object Detection, Image Generation)
//   Widget _buildControlSwitch(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.purple.shade300,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//             Switch(
//               value: true,
//               onChanged: (value) {},
//               activeColor: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
