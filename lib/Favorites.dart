import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_2/CommunityDiscussionPage.dart';
import 'package:flutter_application_2/product_page_forscan.dart';
import 'package:flutter_application_2/scan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Community.dart';
import 'SearchResultsPage.dart';
import 'ProfilePage.dart';
import 'dart:async'; // Added for using Future
import 'CommunityDiscussionPage.dart';
import 'package:flutter_application_2/models/productF-.dart';

import 'chatbot.dart';
import 'product_page.dart';
import 'second_page.dart';

class favorites extends StatefulWidget {
  final String email;

  const favorites({Key? key, required this.email}) : super(key: key);

  @override
  _favoritesState createState() => _favoritesState();
}

class _favoritesState extends State<favorites> {
  late String photo = "";
  late String email = "";
  List<String> productNamescb = [];
  List<Product> productscb = [];
  bool isLoading = true;
  int _activeIndex = 1;// Track loading state





  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    await _fetchUserProfile();  // Ensure this method fetches user profile and potentially sets 'email'
    _fetchfavorites(email);
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
          photo = responseData['photo_name'];
          email = responseData['email'];
          print(email);
        });
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }




  Future<void> _fetchfavorites(String email) async {
    print("Fetching products for email: $email");
    setState(() {
      isLoading = true;  // Start loading
    });
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.15:9000/${email}/favorites/'),
      );

      print("HTTP Response Code: ${response.statusCode}");
      print("HTTP Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> productList = responseData['products'];
        setState(() {
          productNamescb.clear();
          productscb.clear();
          for (var productJson in productList) {
            Product product = Product.fromJson(productJson);
            productscb.add(product);
            productNamescb.add(product.productName);
          }
          print(productNamescb);
          isLoading = false;  // Stop loading after data is fetched
        });
      } else {
        setState(() {
          isLoading = false;  // Stop loading if there's an error
        });
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false;  // Ensure loading is stopped if an exception occurs
      });
      print('Error fetching products: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF6EC),
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(47), // Adjust the preferred height as needed
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              color: Color(0xFFECBE5C),
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfilePage(email: widget.email)));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Placeholder or loading indicator
                    CircularProgressIndicator(),
                    // Replace this with your desired placeholder widget
                    // Image asset
                    Image.asset(
                      photo.isNotEmpty
                          ? 'assets/icons/$photo'
                          : 'assets/images/amis.png',
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      body:  isLoading
          ? Center(
        child: CircularProgressIndicator(color: Color(0xffECBE5C)),
      )
          : CustomScrollView(
        slivers: <Widget>[
          buildProductsSliver(productNames: productNamescb, products: productscb),
          // Additional SliverWidgets if needed
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFFDF6EC).withOpacity(0.01),
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
                MaterialPageRoute(builder: (context) => Chatbot()),
              );
            },
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset('assets/images/robot.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _activeIndex = 1;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => favorites(email: widget.email)),
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
                MaterialPageRoute(builder: (context) => ScanApp(email: widget.email)),
              );
            },
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset('assets/images/code-barres-lu.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _activeIndex = 3;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>SecondPage(email: widget.email)),
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
                MaterialPageRoute(builder: (context) => Community(email: widget.email)),
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

// Method to build the products section as a sliver
  Widget buildProductsSliver({
    required List<String> productNames,
    required List<Product> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0, // Adds a subtle shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10.0),
                  // Inner padding for the card
                  child: Row(
                    children: <Widget>[
                      // Left side: Text information including the score
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              productNames[index], // The name of the product
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'SF Pro Text',
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${products[index].nutriScoreOutOf100}/100',
                              // The nutriScoreOutOf100 score
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'SF Pro Text',
                              ),
                            ),
                            SizedBox(height: 4,),
                            SizedBox(
                              width: 30, // Set the width of the button
                              height: 30, // Set the height of the button
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  backgroundColor: Color(0xffECBE5C),
                                  padding: EdgeInsets
                                      .zero, // Set padding to zero for a smaller button
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20, // Set a smaller icon size
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(
                                              email: widget.email,
                                              productId: products[index].code),
                                    ),
                                  );
                                  // Your onPressed callback
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      // Right side: Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        // Same border radius as the card
                        child: Image.memory(
                          products[index].backgroundImage,
                          width: 100, // Set your desired image width
                          height: 100, // Set your desired image height
                        ),
                      ),
                      // Button
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: productNames.length,
        ),
      ),
    );
  }
}
