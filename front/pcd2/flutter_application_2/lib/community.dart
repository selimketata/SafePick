import 'package:flutter/material.dart';

void main() {
  runApp(const community());
}

class community extends StatelessWidget {
  const community({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('community'),
        ),
        body: const Center(
          child: Text(
            'community',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}