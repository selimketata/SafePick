import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String email;

  const ProfilePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double circleSize = 1.5 * screenSize.width; // Increase the size of the circles

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -0.4* screenSize.width, // Position the circles above the top edge of the screen
            left: -0.4 * screenSize.width, // Position the circles to the left
            child: OverflowBox(
              maxWidth: screenSize.width * 1.6, // Extend the width to cover the entire screen width
              maxHeight: screenSize.width * 1.6, // Extend the height to cover the entire screen width
              child: Container(
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF5CB287),
                ),
              ),
            ),
          ),
          Positioned(
            top: -1* screenSize.width, // Position the circles above the top edge of the screen
            right: - 1* screenSize.width, // Position the circles to the right
            child: OverflowBox(
              maxWidth: screenSize.width * 1.6, // Extend the width to cover the entire screen width
              maxHeight: screenSize.width * 1.6, // Extend the height to cover the entire screen width
              child: Container(
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFECBE5C),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Logged iNn as:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  email,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement logout functionality if needed
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
