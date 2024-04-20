import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import './page1.dart';
import './sign in.dart';
import 'chatbot.dart';
import 'community.dart';
import 'cosmetic.dart';
import 'food.dart';
import 'scan.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LiquidSwipePage(),
        '/chatbot': (context) => const chatbot(),
        '/cosmetic': (context) => const cosmetic(),
        '/scan': (context) => const ScanApp(),
        '/food': (context) => const food(),
        '/community': (context) => Community(),
      },
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
    final pages = [
      FirstPage(),
      SeconPage(),
      ThirdPage(),
      SignIn(),
    ];

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
