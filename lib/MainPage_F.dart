import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_2/CommunityDiscussionPage.dart';
import 'package:flutter_application_2/product_page_forscan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'SearchResultsPage.dart';
import 'ProfilePage.dart';
import 'dart:async'; // Added for using Future
import 'CommunityDiscussionPage.dart';
import 'package:flutter_application_2/models/productF-.dart';

import 'product_page.dart';

class mainpagef extends StatefulWidget {
  final String email;

  const mainpagef({Key? key, required this.email}) : super(key: key);

  @override
  _mainpagefState createState() => _mainpagefState();
}

class _mainpagefState extends State<mainpagef> {
  late String photo = "";
  late String email = "";
  int _selectedIndex = 0;
  List<Product> products = [];
  List<String> productNames = [];
  List<String> productNamescb = [];
  List<Product> productscb = [];
  List<Product> _products = [];

  final TextEditingController _controller = TextEditingController();

  void _navigateToSearchResults(String query) {
    if (query.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(email: widget.email,query: query),
        ),
      );
    }
  }






  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    await _fetchUserProfile();  // Ensure this method fetches user profile and potentially sets 'email'
    _fetchProductsByCategory(items[0]['text']);
    _fetchcontentbased(email);
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


  Future<void> _fetchProductsByCategory(String category) async {
    print("Fetching products for category: $category");
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.15:9000/food/category/$category/'),
      );

      print("HTTP Response Code: ${response.statusCode}");
      print("HTTP Response Body: ${response
          .body}"); // This will show exactly what the API returned

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> productList = responseData['products'];
        setState(() {
          products.clear();
          productNames.clear();
          for (var productJson in productList) {
            Product product = Product.fromJson(productJson);
            products.add(product); // Add the product object to the products list
            productNames.add(product.productName);
          }
          print(productNames);
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> _fetchcontentbased(String email) async {
    print("Fetching products for email: $email");
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.15:9000/${email}/contentbased/'),
      );

      print("HTTP Response Code: ${response.statusCode}");
      print("HTTP Response Body: ${response
          .body}"); // This will show exactly what the API returned

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> productList = responseData['products'];
        setState(() {
          for (var productJson in productList) {
            Product product = Product.fromJson(productJson);
            productscb.add(product); // Add the product object to the products list
            productNamescb.add(product.productName);
          }
          print(productNamescb);
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }


  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/images/lait.png',
      'text': 'Dairy',
      'color': Color(0xffFDF6EC),
    },
    {
      'image': 'assets/images/snacks.png',
      'text': 'Snacks',
      'color': Color(0xffFDF6EC),
    },
    {
      'image': 'assets/images/sauces.png',
      'text': 'Sauces',
      'color': Color(0xffFDF6EC),
    },
    {
      'image': 'assets/images/sac-de-graines.png',
      'text': 'Grains',
      'color': Color(0xffFDF6EC),
    },
    {
      'image': 'assets/images/proteine.png',
      'text': 'Protein',
      'color': Color(0xffFDF6EC),
    },
    {
      'image': 'assets/images/fruit.png',
      'text': 'Fruits',
      'color': Color(0xffFDF6EC),
    },
    // Add more items here
  ];


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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
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
                    'Find your alternative now!',
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
          SliverPadding(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16),
            sliver: SliverToBoxAdapter(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  filled: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                onSubmitted: _navigateToSearchResults,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'SF Pro Text',
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        _fetchProductsByCategory(items[index]['text']);
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? Color(0xffECBE5C)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            items[index]['image'],
                            width: 60,
                            height: 60,
                          ),
                          Text(
                            items[index]['text'],
                            style: TextStyle(
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left:16.0,right:16.0,top:16.0), // Adjust the padding as needed
              child: Text(
                'Recommended for you:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'SF Pro Text',
                ),
              ),
            ),
          ),
          buildProductsSliver(productNames: productNamescb, products: productscb),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left:16.0,right:16.0,top:16.0), // Adjust the padding as needed
              child: Text(
                'Products:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'SF Pro Text',
                ),
              ),
            ),
          ),
          buildProductsSliver(productNames: productNames, products: products),
          // Call a method that returns a SliverList or SliverGrid
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
