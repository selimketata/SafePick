import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ProfilePage.dart';

class SecondPage extends StatefulWidget {

  final String email;

  const SecondPage({Key? key, required this.email}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _currentIndex = 0;

  List<String> _icons = [
    'assets/images/icon1.png',
    'assets/images/icon2.png',
    'assets/images/icon3.png',
    'assets/images/icon4.png',
    'assets/images/icon5.png',
  ];
  late String username = "";
  late String photo = "";

  @override
  void initState() {
    super.initState();
    _fetchUserPhoto();
  }

  Future<void> _fetchUserPhoto() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.16:9000/get_user_profile/'),
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

  List<String> _routes = [
    '/community',
    '/food',
    '/cosmetic',
    '/chatbot',
    '/scan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EC),
      body: Stack(
        children: [
          Positioned(
            top: 42,
            left: 30,
            child: GestureDetector(
              onTap: () {
                // Navigate to help page
              },
              child: Icon(
                Icons.help_outline, // Change to the icon you want
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 33,
            right: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
  builder: (context) => ProfilePage(email: widget.email)));

              },
              child: Image.asset(
                'assets/icons/$photo', // Replace 'your_image.png' with your actual image path
                width: 50, // Adjust width as needed
                height: 50, // Adjust height as needed
              ),
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 150),
              const Text(
                'SafePick',
                style: TextStyle(
                  fontSize: 54,
                  fontFamily: 'Harmonia',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 140), // Adding space here
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Injected padding here
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.55,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          height: 400,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        itemCount: _icons.length,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, _routes[index]);
                                },
                                child: SizedBox(
                                  height: 200, // Adjust the height here
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0), // Add padding here

                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 70, // Adjust these values
                                          left: 16, // Adjust these values
                                          child: Container(
                                            width: 180,
                                            height:
                                                220, // Adjust width of the slide
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .white, // Add background color here
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 4, // Adjust these values
                                          left: 42, // Adjust these values
                                          child: Opacity(
                                            opacity: _currentIndex == index
                                                ? 1.0
                                                : 0.3,
                                            child: Image.asset(
                                              _icons[index],
                                              width: 130.0,
                                              height: 130.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 250, // Adjust these values
                                          left: 77, // Adjust these values
                                          child: ElevatedButton(
                                            onPressed: () {
                                              String secondPageRoute =
                                                  _routes[index];

                                              Navigator.pushNamed(
                                                  context, secondPageRoute);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color(0xFFECBE5C)),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15.0,
                                                    vertical: 13.0),
                                              ),
                                              side: MaterialStateProperty.all<
                                                  BorderSide>(
                                                BorderSide(
                                                  color: Colors.white,
                                                  width: 5.0,
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              '\u2192',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Harmonia',
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF000000),
                                              ),
                                            ),
                                          ),
                                        ), // Container
                                      ], // Stack children
                                    ), // Stack
                                  ), // Padding
                                ), // SizedBox
                              ); // GestureDetector
                            }, // Builder
                          ); // GestureDetector
                        }, // itemBuilder
                      ), // CarouselSlider.builder
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_icons.length, (index) {
                          return Container(
                            width:
                                15.0, // Ajustez la taille du conteneur extérieur selon vos besoins
                            height:
                                15.0, // Ajustez la taille du conteneur extérieur selon vos besoins
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Stack(
                              children: [
                                Container(
                                  width:
                                      30.0, // Ajustez la taille du grand cercle selon vos besoins
                                  height:
                                      30.0, // Ajustez la taille du grand cercle selon vos besoins
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 2.0), // Bordure du grand cercle
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndex == index
                                          ? Colors
                                              .black // Couleur du point actif
                                          : Colors
                                              .transparent, // Couleur transparente pour les points inactifs
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Stack containing circles
          Positioned(
            top: 140,
            left: 50,
            child: _buildCircle(const Color(0xFFECBE5C), 40),
          ),
          Positioned(
            top: 130,
            right: 10,
            child: _buildCircle(const Color(0xFFECBE5C), 50),
          ),
          Positioned(
            top: 250,
            right: 230,
            child: _buildCircle(const Color(0xFFECBE5C), 15),
          ),
          Positioned(
            top: 250,
            left: 60,
            child: _buildCircle(const Color(0xFF5CB287), 70),
          ),
          Positioned(
            top: 240,
            right: 50,
            child: _buildCircle(const Color(0xFF5CB287), 30),
          ),
          Positioned(
            top: 130,
            right: 150,
            child: _buildCircle(const Color(0xFF5CB287), 15),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
