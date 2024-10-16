import 'package:calculator/screens_pages/home_page.dart';
import 'package:flutter/material.dart';

main() {
  runApp(const MyApplication());
}

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()
    );
  }
}



