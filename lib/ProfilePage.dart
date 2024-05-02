import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'UpdateUsernamePage.dart';
import "sign in.dart";
import "UpdateUserpasswordPage.dart";

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

  void _removeAccount() async {
    final Uri apiUrl = Uri.parse(
        'http://192.168.1.16:9000/delete_user_profile/'); // Adjust URL as necessary

    try {
      final response = await http.delete(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': widget.email,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignIn()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to remove account. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
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
                  _buildMenuItem(context, Icons.edit, 'Edit User Name',
                      screenSize.width - 90),
                  SizedBox(height: 20),
                  _buildMenuItem(context, Icons.lock, 'Change Password',
                      screenSize.width - 90),
                  SizedBox(height: 20),
                  _buildMenuItem(context, Icons.person_remove, 'Remove account',
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
                  photo.isNotEmpty
                      ? 'assets/icons/$photo'
                      : 'assets/images/amis.png',
                  width: 50,
                  height: 50,
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
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData iconData, String text, double width, {Color textColor = Colors.black}) {
  return GestureDetector(
    onTap: () async {
      if (text == 'Edit User Name') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UpdateUsernamePage(email: widget.email),
          ),
        ).then((value) {
          if (value == true) {
            _fetchUserProfile(); // Refresh the profile data
          }
        });
      } else if (text == 'Change Password') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UpdateUserPasswordPage(email: widget.email),
          ),
        );
      } else if (text == 'Remove account') {
        bool confirmed = await _showConfirmDialog(
          context,
          'Remove Account',
          'Are you sure you want to remove your account? This action cannot be undone.'
        );
        if (confirmed) {
          _removeAccount();
        }
      } else if (text == 'Log Out') {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignIn()),
          (Route<dynamic> route) => false,
        );
      }
    },
    child: _menuItemContent(iconData, text, width, textColor),
  );
}

  Widget _menuItemContent(
      IconData iconData, String text, double width, Color textColor) {
    return Container(
      height: 59,
      width: width,
      color: Color(0xFFD9D9D9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(iconData, color: textColor),
          ),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: textColor)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.arrow_forward, color: textColor),
          ),
        ],
      ),
    );
  }

  Future<bool> _showConfirmDialog(
      BuildContext context, String title, String content) async {
    return (await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: Text('Yes', style: TextStyle(color: Colors.red)),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        )) ??
        false; // Handle null by treating it as "false"
  }
}
