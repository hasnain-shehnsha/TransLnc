import 'package:flutter/material.dart';
import 'phone_login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Welcome to TransLync",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  'assets/pattern.png', // Add this image in assets
                  width: 250,
                  height: 250,
                ),
                Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: const [
                        Text(
                          "Read our ",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Privacy Policy",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                        Text(" . Tap \"Agree and continue\" to accept the "),
                        Text(
                          "Terms of Service.",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PhoneLogin()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0A66C2), // WhatsApp green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "AGREE AND CONTINUE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Column(
                  children: [
                    Text(
                      "from",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "TransLync",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
