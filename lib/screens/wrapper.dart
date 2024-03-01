import 'package:ada_hackathon_app/widgets/doctor.dart';
import 'package:ada_hackathon_app/widgets/home.dart';
import 'package:ada_hackathon_app/widgets/insurance.dart';
import 'package:ada_hackathon_app/widgets/profile.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

var screens = [
  const HomePage(),
  const Insurance(),
  const DoctorPage(),
  const ProfilePage()
];

class _WrapperScreenState extends State<WrapperScreen> {
  var index = 0;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: index,
        
        onTap: (idx) {
          setState(() {
            index = idx;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.health_and_safety_outlined), label: 'shield'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: 'med'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person')
        ],
      ),
    );
  }
}
