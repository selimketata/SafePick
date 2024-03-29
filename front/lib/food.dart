import 'package:flutter/material.dart';

void main() {
  runApp(const food());
}

class food extends StatelessWidget {
  const food({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('food'),
        ),
        body: const Center(
          child: Text(
            'food',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
