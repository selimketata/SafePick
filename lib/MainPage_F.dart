import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_2/CommunityDiscussionPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ProfilePage.dart';
import 'dart:async'; // Added for using Future
import 'CommunityDiscussionPage.dart';

class mainpagef extends StatefulWidget {
  final String email;

  const mainpagef({Key? key, required this.email}) : super(key: key);

  @override
  _mainpagefState createState() => _mainpagefState();
}

class _mainpagefState extends State<mainpagef> {
  late String photo = "";


  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose any resources if needed
  }

  Future<void> _fetchUserProfile() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.13:9000/get_user_profile/'),
        body: {'email': widget.email},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
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
    return Scaffold(
      backgroundColor: Color(0xffFDF6EC),
      body: Container(
      ),
    );
  }
}