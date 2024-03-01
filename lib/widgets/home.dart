import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('user');

  @override
  void initState() {
    super.initState();
    _myBox.put('date', '31/08/03');
    _myBox.put('fin', '8MM9L31');
    _myBox.put('tel', '+994 51 677 89 12');
    _myBox.put('email', 'johndue@gmail.com');
    _myBox.put('workplace', 'Azintelecom');
    _myBox.put('profession', 'IT specialist');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home'),
    );
  }
}

class StatisticCard extends StatelessWidget {
  const StatisticCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.value});

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            Text(value, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
