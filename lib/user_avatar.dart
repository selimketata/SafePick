import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final Function(String) onAvatarSelected;

  final String selectedAvatar;
  const UserAvatar({super.key, 
    required this.onAvatarSelected,
    required this.selectedAvatar, // Add selectedAvatar parameter to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Choose Your Avatar',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(238, 166, 66, 1),
                ),
              ),
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling of GridView
              shrinkWrap: true, // Allow GridView to scroll within SingleChildScrollView
              crossAxisCount: 3, // Adjust the crossAxisCount based on your preference
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              children: [
                for (int i = 1; i <= 25; i++)
                  GestureDetector(
                    onTap: () {
                      // Send the selected image back to the Signup page
                      onAvatarSelected('assets/icons/profil$i.png');
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/icons/profil$i.png', // Assuming your image assets are named as profil1.png, profil2.png, etc.
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
