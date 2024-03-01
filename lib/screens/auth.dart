import 'package:ada_hackathon_app/utils/authentication.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Login'),
              const SizedBox(
                height: 28,
              ),
              const Text('User your fingerprint to login the app'),
              const SizedBox(
                height: 28,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  bool auth = await Authentication.authentication();
                  print("can authenticate: $auth");
                },
                icon: const Icon(Icons.fingerprint),
                label: const Text('Authenticate'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
