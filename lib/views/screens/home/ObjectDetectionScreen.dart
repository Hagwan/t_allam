// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:tflite_v2/tflite_v2.dart';

// class ObjectDetectionScreen extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   ObjectDetectionScreen({required this.cameras});

//   @override
//   _ObjectDetectionScreenState createState() => _ObjectDetectionScreenState();
// }

// class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
//   late CameraController _controller;
//   bool isModelLoaded = false;
//   bool isDetecting = false;
//   List<dynamic>? recognitions;
//   int imageHeight = 0;
//   int imageWidth = 0;

//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//     initializeCamera(null);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> loadModel() async {
//     String? res = await Tflite.loadModel(
//       model: 'lib/assets/tf/detect.tflite',
//       labels: 'lib/assets/tf/labelmap.txt',
//     );
//     setState(() {
//       isModelLoaded = res != null;
//     });
//   }

//   void toggleCamera() {
//     final lensDirection = _controller.description.lensDirection;
//     CameraDescription newDescription;
//     if (lensDirection == CameraLensDirection.front) {
//       newDescription = widget.cameras.firstWhere((description) =>
//           description.lensDirection == CameraLensDirection.back);
//     } else {
//       newDescription = widget.cameras.firstWhere((description) =>
//           description.lensDirection == CameraLensDirection.front);
//     }

//     if (newDescription != null) {
//       initializeCamera(newDescription);
//     } else {
//       print('Requested camera not available');
//     }
//   }

//   void initializeCamera(CameraDescription? description) async {
//     if (widget.cameras.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No cameras found on this device.')),
//       );
//       return;
//     }

//     _controller = CameraController(
//       description ?? widget.cameras[0],
//       ResolutionPreset.high,
//       enableAudio: false,
//     );

//     await _controller.initialize();

//     if (!mounted) return;

//     _controller.startImageStream((CameraImage image) {
//       if (isModelLoaded && !isDetecting) {
//         runModel(image);
//       }
//     });
//     setState(() {});
//   }

//   void runModel(CameraImage image) async {
//     setState(() {
//       isDetecting = true;
//     });

//     if (image.planes.isEmpty) {
//       setState(() {
//         isDetecting = false;
//       });
//       return;
//     }

//     var recognitions = await Tflite.detectObjectOnFrame(
//       bytesList: image.planes.map((plane) => plane.bytes).toList(),
//       model: 'SSDMobileNet',
//       imageHeight: image.height,
//       imageWidth: image.width,
//       imageMean: 127.5,
//       imageStd: 127.5,
//       numResultsPerClass: 1,
//       threshold: 0.4,
//     );

//     setState(() {
//       this.recognitions = recognitions;
//       isDetecting = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.cameras.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Real-time Object Detection'),
//         ),
//         body: Center(child: Text('No cameras found on this device.')),
//       );
//     }

//     if (!_controller.value.isInitialized) {
//       return Container();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Real-time Object Detection'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.8,
//             child: Stack(
//               children: [
//                 Center(child: CameraPreview(_controller)),
//                 if (recognitions != null)
//                   BoundingBoxes(
//                     recognitions: recognitions!,
//                     previewH: imageHeight.toDouble(),
//                     previewW: imageWidth.toDouble(),
//                     screenH: MediaQuery.of(context).size.height * 0.8,
//                     screenW: MediaQuery.of(context).size.width,
//                   ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: toggleCamera,
//                 icon: Icon(
//                   Icons.camera_front,
//                   size: 30,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BoundingBoxes extends StatelessWidget {
//   final List<dynamic> recognitions;
//   final double previewH;
//   final double previewW;
//   final double screenH;
//   final double screenW;

//   BoundingBoxes({
//     required this.recognitions,
//     required this.previewH,
//     required this.previewW,
//     required this.screenH,
//     required this.screenW,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: recognitions.map((rec) {
//         var x = rec["rect"]["x"] * screenW;
//         var y = rec["rect"]["y"] * screenH;
//         double w = rec["rect"]["w"] * screenW;
//         double h = rec["rect"]["h"] * screenH;

//         return Positioned(
//           left: x,
//           top: y,
//           width: w,
//           height: h,
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.purpleAccent,
//                 width: 3,
//               ),
//             ),
//             child: Text(
//               rec["confidenceInClass"] >= 0.5
//                   ? "${rec["detectedClass"]} ${(rec["confidenceInClass"] * 100).toStringAsFixed(0)}%"
//                   : "",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 background: Paint()..color = Colors.purple,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
