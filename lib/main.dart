import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NacarioSoftware',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.yellow,
      ),
      home: const HomePage(title: 'NacarioSoftware'),
    );
  }
}

