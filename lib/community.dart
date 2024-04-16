import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFDF6EC),

        child: Stack(
          children: [
            Align(
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
            Positioned(
              top: 180, // Adjust the position of the search bar
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 41,
                        width: 300, // Adjust width to fit screen
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 16),
                            SizedBox(width: 8),
                            Text(
                              'Find a community',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 41,
                        width: 41,
                        margin: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(
                          color: Color(0xFF5CB287),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.search, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(height: 25), // Add vertical spacing here
                  Row(
                    children: [
                      Text(
                        'Socials',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'SF Pro Text',
                        ),
                      ),
                      SizedBox(width: 300),
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'SF Pro Text',
                        ),
                      ),
                    ],

                  ),
                  SizedBox(width: 500),
                  SizedBox(width:100),
                  Container(
                    height: 2,
                    width : 380,
                    color: Color(0xFF5CB287),
                  ),
                  SizedBox(width : 300),
                  SizedBox(height: 20), // Add vertical spacing
                  Container(
                    height: 55,
                    width: 380,
                    // D9D9D9 color with 35% opacity
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),// Add padding to align content
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Skin Care',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'SF Pro Text',
                          ),
                        ),
                        Image.asset(
                          'assets/images/chat-bulle.png', // Replace with your image path
                          width: 30, // Adjust width as needed
                          height: 30, // Adjust height as needed
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width : 300),
                  SizedBox(height: 10), // Add vertical spacing
                  Container(
                    height: 55,
                    width: 380,
                    // D9D9D9 color with 35% opacity
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),// Add padding to align content
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Perfumes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'SF Pro Text',
                          ),
                        ),
                        Image.asset(
                          'assets/images/chat-bulle.png', // Replace with your image path
                          width: 30, // Adjust width as needed
                          height: 30, // Adjust height as needed
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width : 300),
                  SizedBox(height: 10), // Add vertical spacing
                  Container(
                    height: 55,
                    width: 380,
                    // D9D9D9 color with 35% opacity
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),// Add padding to align content
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Drinks',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'SF Pro Text',
                          ),
                        ),
                        Image.asset(
                          'assets/images/chat-bulle.png', // Replace with your image path
                          width: 30, // Adjust width as needed
                          height: 30, // Adjust height as needed
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(height: 25), // Add vertical spacing here
                  Row(
                    children: [
                      Text(
                        'Discover More',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'SF Pro Text',
                        ),
                      ),
                      SizedBox(width: 253),
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'SF Pro Text',
                        ),
                      ),
                    ],

                  ),
                  SizedBox(width: 500),
                  SizedBox(width:100),
                  Container(
                    height: 2,
                    width : 380,
                    color: Color(0xFF5CB287),
                  ),
                  SizedBox(width : 300),
                  SizedBox(height: 20), // Add vertical spacing
                  Container(
                    height: 55,
                    width: 380,
                    // D9D9D9 color with 35% opacity
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),// Add padding to align content
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Coffee',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'SF Pro Text',
                          ),
                        ),
                        Image.asset(
                          'assets/images/plus.png', // Replace with your image path
                          width: 30, // Adjust width as needed
                          height: 30, // Adjust height as needed
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width : 300),
                  SizedBox(height: 10), // Add vertical spacing
                  Container(
                    height: 55,
                    width: 380,
                    // D9D9D9 color with 35% opacity
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),// Add padding to align content
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Healthy Snacks',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'SF Pro Text',
                          ),
                        ),
                        Image.asset(
                          'assets/images/plus.png', // Replace with your image path
                          width: 30, // Adjust width as needed
                          height: 30, // Adjust height as needed
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width : 300),
                  SizedBox(height: 10), // Add vertical spacing
                  Container(
                    height: 55,
                    width: 380,
                    // D9D9D9 color with 35% opacity
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 0.35),
                      borderRadius: BorderRadius.circular(10),
                    ),// Add padding to align content
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chips',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'SF Pro Text',
                          ),
                        ),
                        Image.asset(
                          'assets/images/plus.png', // Replace with your image path
                          width: 30, // Adjust width as needed
                          height: 30, // Adjust height as needed
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
            Positioned(
              top: 35,
              right: 16,
              child: Image.asset(
                'assets/images/femme.png', // Replace with your image path
                width: 42,
                height: 42,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFFDF6EC),
        color: Color(0xFFECBE5C).withOpacity(0.9),
        animationDuration: Duration(milliseconds: 250),
        items: [
          Container(
            width: 30,
            height: 30,
            child: Image.asset('assets/images/robot.png'),
          ),
          Icon(Icons.favorite),
          Container(
            width: 30,
            height: 30,
            child: Image.asset('assets/images/code-barres-lu.png'),
          ),
          Icon(Icons.home),
          GestureDetector(
            onTap: () {
              // Replace the current route with CommunityPage when pressed
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Community()),
              );
            },
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset('assets/images/amis.png'),
            ),
          ),
        ],
      ),


    );
  }
}

