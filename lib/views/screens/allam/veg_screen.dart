import 'package:flutter/material.dart';
import '../../../models/veg_model.dart';
class VegetableScreen extends StatefulWidget {
  @override
  _VegetableScreenState createState() => _VegetableScreenState();
}

class _VegetableScreenState extends State<VegetableScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _vegetableName;

  void _generateVegetableName() async {
    final generator = VegetableGenerator();
    try {
      final name = await generator.getVegetableName(_controller.text);
      //show the generated vegetable name in terminal 
      print(name);
      setState(() {
        _vegetableName = name;
      });
    } catch (e) {
      setState(() {
        _vegetableName = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vegetable Name Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Arabic Letter',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateVegetableName,
              child: Text('Generate Vegetable Name'),
            ),
            SizedBox(height: 20),
            if (_vegetableName != null)
              Text(
                'Vegetable Name: $_vegetableName',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
