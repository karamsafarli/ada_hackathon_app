// import 'package:ada_hackathon_app/screens/auth.dart';
import 'package:ada_hackathon_app/screens/login.dart';
import 'package:ada_hackathon_app/screens/wrapper.dart';
// import 'package:ada_hackathon_app/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final myBox = Hive.box('user');

    return MaterialApp(
      title: 'Insurance app',
      debugShowCheckedModeBanner: false,
      
      home: myBox.get('name') != null
          ? const WrapperScreen()
          : const LoginScreen(),
    );
  }
}