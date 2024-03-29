import 'package:flutter/material.dart';

void main() {
  runApp(const scan());
}

class scan extends StatelessWidget {
  const scan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('scan'),
        ),
        body: const Center(
          child: Text(
            'scan',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
