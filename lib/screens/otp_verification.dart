import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'set_details.dart';
import 'dart:async'; // IMPORTANT!
class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final bool isTestNumber;

  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
    this.isTestNumber = false,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  Timer? _timer;
  bool isButtonEnabled = false;
  int _secondsRemaining = 60;


  @override
  void initState() {
    super.initState();
    startTimer();
    for (var controller in controllers) {
      controller.addListener(_checkOtpFilled);
    }
  }





  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }


  void _checkOtpFilled() {
    bool allFilled = controllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      isButtonEnabled = allFilled;
    });

    // Auto-verify when 6 digits are entered
    if (allFilled) {
      _verifyOtp();
    }
  }


  Future<void> _verifyOtp() async {
    String otp = controllers.map((c) => c.text).join();
    print("Attempting to verify OTP: $otp");
    print("Using verification ID: ${widget.verificationId}");
    
    if (widget.isTestNumber && otp != "123456") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("For test numbers, please use code: 123456")),
      );
      return;
    }

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      print("Created credential, attempting to sign in...");
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      print("Successfully signed in! User: ${userCredential.user?.uid}");
      
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SetInfo()),
      );
    } catch (e) {
      print("Error during OTP verification: $e");
      print("OTP entered: $otp");
      print("Verification ID: ${widget.verificationId}");
      
      String errorMessage = "Invalid OTP. ";
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-verification-code') {
          errorMessage += "Please enter the correct code.";
        } else if (e.code == 'invalid-verification-id') {
          errorMessage += "Verification expired. Please try again.";
        } else if (e.code == 'network-request-failed') {
          errorMessage += "Network error. Please check your connection.";
        } else {
          errorMessage += e.message ?? "Please try again.";
        }
      } else {
        errorMessage += "An unexpected error occurred. Please try again.";
      }
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 45,
      height: 55,
      child: TextField(
        controller: controllers[index],
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 22),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Enter OTP Code',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 180),
              Text(
                'Code has been sent to ${widget.phoneNumber}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) => _buildOtpBox(index)),
              ),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Resend Code in ',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      TextSpan(
                        text: '$_secondsRemaining',
                        style: const TextStyle(color: Colors.teal),
                      ),
                      const TextSpan(text: ' s'),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled ? _verifyOtp : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isButtonEnabled ? Colors.black : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
