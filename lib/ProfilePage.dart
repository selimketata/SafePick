import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String email;

  const ProfilePage({Key? key, required this.email}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String username = "";
  late String photo = "";

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.16:9000/get_user_profile/'),
        body: {'email': widget.email},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          username = responseData['username'];
          photo = responseData['photo_name'];
        });
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double circleSize =
        0.8 * screenSize.width; // Set the size of the circles
    final double imageRadius = 180; // Set the radius of the image circle

    return Scaffold(
     
      backgroundColor:
          Color(0xFFFDF6EC), // Set the background color of the scaffold
      body: Stack(
        children: [
          Positioned(
            top: -0.28 * circleSize, // Adjust the position of the circles
            right: -0.2 * circleSize,
            child: Container(
              height: circleSize,
              width: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5CB287),
              ),
            ),
          ),
          Positioned(
            top: -0.28 * circleSize, // Adjust the position of the circles
            left: -0.2 * circleSize,
            child: Container(
              height: circleSize,
              width: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFECBE5C),
              ),
            ),
          ),
          Positioned(
            top: circleSize * 0.4, // Position the rectangle after the circles
            left: screenSize.width * 0.05, // Adjusted left position
            right: screenSize.width * 0.05, // Adjusted right position
            child: Container(
              height: 490,
              decoration: BoxDecoration(
                color: Colors.white, // Set the color of the rectangle to white
                borderRadius:
                    BorderRadius.circular(20), // Set circular border radius
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 100), // Adjust the height as needed
                  Text(
                    username, // The user's name
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20), // Adjust the height as needed
                  _buildMenuItem(context, Icons.edit, 'Edit Profile',
                      screenSize.width - 90),
                  SizedBox(height: 20),
                  _buildMenuItem(context, Icons.lock, 'Change Password',
                      screenSize.width - 90),
                  SizedBox(height: 20),
                  _buildMenuItem(context, Icons.email, 'Change Email Adress',
                      screenSize.width - 90),
                  SizedBox(height: 20),
                  _buildMenuItem(
                      context, Icons.logout, 'Log Out', screenSize.width - 90,
                      textColor: Colors.red),

                  SizedBox(height: 20), // Adjust the height as needed
                ],
              ),
            ),
          ),
          Positioned(
            top: circleSize * 0.4 -
                imageRadius /
                    2, // Position the image circle vertically centered
            left: screenSize.width * 0.5 -
                imageRadius /
                    2, // Position the image circle horizontally centered
            child: Container(
              height: imageRadius,
              width: imageRadius,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Set the color of the circle to white
              ),
              padding: EdgeInsets.all(
                  20), // Add padding to create space around the image
              child: ClipOval(
                child: Image.asset(
                  'assets/icons/$photo',
                  fit: BoxFit.cover, // Cover the entire circle with the image
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Navigate to the previous page
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData iconData, String text, double width,
      {Color textColor = Colors.black}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Add navigation logic here
            // For example:
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnotherPage()));
          },
          child: Container(
            height: 59,
            width: width,
            color: Color(0xFFD9D9D9), // Set the color of the rectangle
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    iconData,
                    color: iconData == Icons.logout
                        ? Colors.red
                        : Colors.black, // Set the color of the icon
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'HarmoniaSansW01-Bold,Regular',
                      color: textColor, // Set the color of the text
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.arrow_forward, // Custom icon for navigation
                    color: iconData == Icons.logout
                        ? Colors.red
                        : Colors.black, // Set the color of the icon
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 0.08), // Reduce the space between each item
      ],
    );
  }
}
