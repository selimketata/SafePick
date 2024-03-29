import 'package:flutter/material.dart';

import 'chatbot.dart';
import 'community.dart';
import 'cosmetic.dart';
import 'food.dart';
import 'home_page.dart';
import 'scan.dart';
import 'second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple Pages Example',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/second': (context) => const SecondPage(),
        '/chatbot': (context) => const chatbot(),
        '/cosmetic': (context) => const cosmetic(),
        '/scan': (context) => const scan(),
        '/food': (context) => const food(),
        '/community': (context) => const community(),
      },
    );
  }
}
