import 'package:flutter/material.dart';

void main() {
  runApp(const cosmetic());
}

class cosmetic extends StatelessWidget {
  const cosmetic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('cosmetic'),
        ),
        body: const Center(
          child: Text(
            'cosmetic',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
