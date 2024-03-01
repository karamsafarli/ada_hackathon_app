import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  int? heartRate;
  String? caloriesBurned;
  String? sleepQuality;
  String? bloodOxygen;
  double? healthScore;

  void connect() async {
    Dio dio = Dio();

    String url = 'http://192.168.36.54:5000/predict';

    Map<String, dynamic> data = {
      "input_data": {
        "Heart_Rate": 82,
        "Sleep_Quality": 50,
        "Stress_Level": 25,
        "SpO2": 92,
        "BMI": 25.1,
        "Age": 20,
        "Cigarette_Use": 0,
        "Alcohol_Use": 0,
        "Fitness": 0,
        "Diabetes": 0,
        "Air_Quality_Index": 25,
      },
    };

    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      var hscore = (response.data['prediction'][0] / 100).toFixed(2);
      setState(() {
        heartRate = data['input_data']['Heart_Rate'];
        healthScore = response.data['prediction'][0];
      });
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (error) {
      print('Error: $error');
    }

    // setState(() {
    //   heartRate = 95;
    //   caloriesBurned = '1350kC';
    //   sleepQuality = '78%';
    //   bloodOxygen = '92%';
    //   healthScore = 0;
    //   Timer.periodic(const Duration(milliseconds: 4), (timer) {
    //     setState(() {
    //       healthScore = healthScore! + .005;
    //       if (healthScore! >= 0.82) {
    //         timer.cancel();
    //       }
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Health Statistics',
                style: TextStyle(
                  color: Color(0xff097a5e),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CircularHealthIndicator(
                value: healthScore ?? 0.0,
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: connect,
                  child: const Text(
                    'Connect',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff097a5e),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              StatisticCard(
                icon: Icons.monitor_heart_outlined,
                title: "Heart BPM",
                value: heartRate != null ? '$heartRate' : 'XXX',
              ),
              const SizedBox(
                height: 10,
              ),
              // StatisticCard(
              //   icon: Icons.directions_walk,
              //   title: "Steps",
              //   value: "1990",
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              StatisticCard(
                icon: Icons.local_fire_department,
                title: "Calories burned",
                value: caloriesBurned ?? 'XXX',
              ),
              const SizedBox(
                height: 10,
              ),
              StatisticCard(
                icon: Icons.snooze,
                title: "Sleep quality",
                value: sleepQuality ?? "XXX",
              ),
              const SizedBox(
                height: 10,
              ),
              StatisticCard(
                icon: Icons.favorite,
                title: "Blood oxygen",
                value: bloodOxygen ?? "XXX",
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  const StatisticCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.value,
  }) : super(key: key);

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
            Icon(
              icon,
              color: const Color(0xff097a5e),
              size: 30,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xff097a5e),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xff097a5e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularHealthIndicator extends StatelessWidget {
  final double value;

  const CircularHealthIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 170,
          height: 170,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: const Color(0xffd3d3d3),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff097a5e)),
            strokeWidth: 8,
          ),
        ),
        Text(
          '${(value * 100).toInt()}%', // Display percentage
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff097a5e),
          ),
        ),
      ],
    );
  }
}
