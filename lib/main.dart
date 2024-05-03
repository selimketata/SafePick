import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import './page1.dart';

import './sign in.dart';
import 'chatbot.dart';
import 'community.dart';
import 'cosmetic.dart';
import 'food.dart';

import 'scan.dart';

class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LiquidSwipePage(),
        '/chatbot': (context) => const Chatbot(),
        '/cosmetic': (context) => const cosmetic(),
        '/scan': (context) => ScanApp(
            email: ModalRoute.of(context)!.settings.arguments as String),
        '/food': (context) => const food(),
        '/community': (context) => Community(
            email: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}

class LiquidSwipePage extends StatefulWidget {
  const LiquidSwipePage({super.key});

  @override
  _LiquidSwipePageState createState() => _LiquidSwipePageState();
}

class _LiquidSwipePageState extends State<LiquidSwipePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const FirstPage(),
      const SeconPage(),
      const ThirdPage(),
      const SignIn(),
    ];

    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        enableLoop: false,
        fullTransitionValue: 300,
        enableSideReveal: true,
        slideIconWidget: currentPage != pages.length - 1
            ? const Icon(Icons.arrow_forward_ios)
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
