import 'package:flutter/material.dart';

void main() {
  runApp(const chatbot());
}

class chatbot extends StatelessWidget {
  const chatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('chatbot'),
        ),
        body: const Center(
          child: Text(
            'chatbot',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
