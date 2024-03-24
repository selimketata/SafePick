import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF6EC),
      body: Column(
        children: [
          SizedBox(height: 150),
          Text(
            'SafePick',
            style: TextStyle(
              fontSize: 54,
              fontFamily: 'Harmonia',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 150), // Adding space here
          Expanded(
            child: Column(
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  itemCount: 3, // Set the number of items in your carousel
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Image.network(
                            'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Colors.grey
                            : Colors.grey.withOpacity(
                                0.5), // Change the active and inactive dot colors here
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            top: 140,
            left: 50,
            child: _buildCircle(Color(0xFFECBE5C), 40),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: _buildCircle(Color(0xFFECBE5C), 100),
          ),
          Positioned(
            top: 250,
            right: 230,
            child: _buildCircle(Color(0xFFECBE5C), 15),
          ),
          Positioned(
            top: 250,
            left: 60,
            child: _buildCircle(Color(0xFF5CB287), 70),
          ),
          Positioned(
            top: 240,
            right: 50,
            child: _buildCircle(Color(0xFF5CB287), 30),
          ),
          Positioned(
            top: 130,
            right: 150,
            child: _buildCircle(Color(0xFF5CB287), 15),
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
