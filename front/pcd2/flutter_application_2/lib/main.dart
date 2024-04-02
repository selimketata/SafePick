import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import './page1.dart';
import 'sign in.dart';

// Import the page you want to navigate to

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LiquidSwipePage(),
    );
  }
}

class LiquidSwipePage extends StatefulWidget {
  @override
  _LiquidSwipePageState createState() => _LiquidSwipePageState();
}

class _LiquidSwipePageState extends State<LiquidSwipePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [Signin(),FirstPage(), SecondPage(), ThirdPage(), Signin()];

    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        enableLoop: false,
        fullTransitionValue: 300,
        enableSideReveal: true,
        slideIconWidget: currentPage != pages.length - 1
            ? Icon(Icons.arrow_forward_ios)
            : null,
        waveType: WaveType.liquidReveal,
        positionSlideIcon: 0.5,
        onPageChangeCallback: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }
}
