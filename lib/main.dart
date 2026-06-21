import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'theme.dart';

void main() {
  runApp(const KahveOrmanApp());
}

class KahveOrmanApp extends StatelessWidget {
  const KahveOrmanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KahveOrman',
      debugShowCheckedModeBanner: false,
      theme: kahveOrmanTheme(),
      home: const HomePage(),
    );
  }
}
