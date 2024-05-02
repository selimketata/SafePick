import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_2/CommunityDiscussionPage.dart';
import 'package:flutter_application_2/Favorites.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ProfilePage.dart';
import 'dart:async'; // Added for using Future
import 'CommunityDiscussionPage.dart';
import 'chatbot.dart';
import 'scan.dart';
import 'second_page.dart';

class Community extends StatefulWidget {
  final String email;

  const Community({Key? key, required this.email}) : super(key: key);

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  late String username = "";
  late String photo = "";
  List<String> socialsItems = [];
  List<String> discoverMoreItems = [];
  List<String> userCommunities = [];
  int _activeIndex = 0;  // Default to the first tab

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
    _fetchUserCommunities();
    _fetchCommunitiesNotUserExists();
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose any resources if needed
  }

  Future<void> _fetchUserProfile() async {
    try {
      final response = await http.post(

        Uri.parse('http://192.168.1.15:9000/get_user_profile/'),

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

  Future<void> _fetchUserCommunities() async {
    try {
      final response = await http.post(

        Uri.parse('http://192.168.1.15:9000/get_user_communities/'),

        body: {'email': widget.email},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          userCommunities = List<String>.from(responseData['communities']);
        });
      } else {
        throw Exception('Failed to load user communities');
      }
    } catch (e) {
      print('Error fetching user communities: $e');
    }
  }

  Future<void> _fetchCommunitiesNotUserExists() async {
    try {
      final response = await http.post(

        Uri.parse('http://192.168.1.15:9000/get_communities_not_user_exists/'),

        body: {'email': widget.email},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          discoverMoreItems =
              List<String>.from(responseData['communities_not_user_exists']);
        });
      } else {
        throw Exception('Failed to load communities user is not part of');
      }
    } catch (e) {
      print('Error fetching communities user is not part of: $e');
    }
  }

  Future<void> _addEmailToCommunity(String communityName) async {
    try {
      final response = await http.post(

        Uri.parse('http://192.168.1.15:9000/add_email_to_community/'),

        body: {'community_name': communityName, 'email': widget.email},
      );

      if (response.statusCode == 201) {
        // Successfully joined the community
        print('Successfully joined the community: $communityName');
        // Refresh user communities
        _fetchUserCommunities();
        // Remove the community from the discover more list
        setState(() {
          discoverMoreItems.remove(communityName);
        });
      } else {
        print('Failed to join the community: $communityName');
      }
    } catch (e) {
      print('Error joining the community: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFDF6EC),
        child: Stack(
          children: [
            Container(
              color: Color(0xFFFDF6EC),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, There!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'SF Pro Text',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'How About Sharing Experience?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontFamily: 'SF Pro Text',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 16,
              right: 16, // Ensure it fits within the screen width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSectionTitle('Socials'),
                  buildScrollableItemList(userCommunities, false),
                  SizedBox(height: 20),
                  buildSectionTitle('Discover More'),
                  buildScrollableItemList(discoverMoreItems, true),
                ],
              ),
            ),
            Positioned(
              top: 50,
              right: 16,
              child: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  photo.isNotEmpty
                      ? 'assets/icons/$photo'
                      : 'assets/images/amis.png',
                  width: 50,
                  height: 50,
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFFDF6EC),
        color: Color(0xFFECBE5C).withOpacity(0.9),
        animationDuration: Duration(milliseconds: 250),
        index: _activeIndex,
        items: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _activeIndex = 0;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatbotPage()),
              );
            },
            child: Icon(Icons.chat),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _activeIndex = 1;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage(email: widget.email)),
              );
            },
            child: Icon(Icons.favorite),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _activeIndex = 2;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanPage(email: widget.email)),
              );
            },
            child: Icon(Icons.camera),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _activeIndex = 3;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(email: widget.email)),
              );
            },
            child: Icon(Icons.home),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _activeIndex = 4;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommunityPage(email: widget.email)),
              );
            },
            child: Icon(Icons.group),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'SF Pro Text',
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xFF5CB287), // Adjust color as needed
          thickness: 2, // Adjust thickness as needed
        ),
      ],
    );
  }

  Widget buildScrollableItemList(List<String> items, bool isDiscoverMore) {
    return Container(
      height: 240, // Limit the height to show only up to 4 items
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: items.map((item) {
            return Container(
              height: 55,
              width: 380,
              padding: EdgeInsets.symmetric(horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 0.35),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'SF Pro Text',
                    ),
                  ),
                  if (isDiscoverMore)
                    GestureDetector(
                      onTap: () => _addEmailToCommunity(item),
                      child: Image.asset(
                        'assets/images/plus.png',
                        width: 30,
                        height: 30,
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        // Navigate to the community page passing email and item only if not "Discover More"
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommunityDiscussionPage(
                                email: widget.email, communityName: item),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/chat-bulle.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
