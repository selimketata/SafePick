import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back to previous page
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
