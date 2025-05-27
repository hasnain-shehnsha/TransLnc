import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_verification.dart'; 

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  String completePhoneNumber = '';

  // 🔒 Starts Firebase phone verification
  void _startPhoneVerification(String phoneNumber) async {
    print("Starting phone verification for: $phoneNumber");
    
    // Check if it's a test phone number
    bool isTestNumber = phoneNumber == "+923404386378";
    if (isTestNumber) {
      print("📱 Using test phone number: $phoneNumber");
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),

        // ⛔ Skip auto sign-in
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("⚠️ Auto verification triggered but skipped intentionally.");
          // Do NOT sign in here so that user always enters the OTP
        },

        // ❌ Verification failed
        verificationFailed: (FirebaseAuthException e) {
          print("❌ Verification failed with error code: ${e.code}");
          print("❌ Error message: ${e.message}");
          
          String errorMessage = "Verification failed: ";
          if (e.code == 'invalid-phone-number') {
            errorMessage += "Invalid phone number format";
          } else if (e.code == 'too-many-requests') {
            errorMessage += "Too many attempts. Please try again later";
          } else {
            errorMessage += e.message ?? "Unknown error";
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        },

        // ✅ Code sent to user's phone
        codeSent: (String verificationId, int? resendToken) {
          print("📲 Code sent successfully!");
          print("📲 Verification ID: $verificationId");
          print("📲 Resend Token: $resendToken");

          if (isTestNumber) {
            print("📱 Test number detected - Use code: 123456");
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                phoneNumber: phoneNumber,
                isTestNumber: isTestNumber,
              ),
            ),
          );
        },

        // ⏱ Auto-retrieval timeout
        codeAutoRetrievalTimeout: (String verificationId) {
          print("⌛ Auto-retrieval timed out. Verification ID: $verificationId");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Verification code timeout. Please try again.")),
          );
        },
      );
    } catch (e) {
      print("❌ Exception during phone verification: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }


  // 📲 Confirmation Dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Phone Number"),
        content: Text("Is this your number?\n\n$completePhoneNumber"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // cancel
            },
            child: const Text("Let me check"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
              _startPhoneVerification(completePhoneNumber); // Start verification
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // 🔧 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Enter your phone number",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: const [
                    Text(
                      "TransLync will need to verify your phone number. ",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "What's my number?",
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 📞 Phone Number Field
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                  initialCountryCode: 'PK',
                  onChanged: (phone) {
                    completePhoneNumber = phone.completeNumber;
                  },
                ),

                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    "Carrier charges may apply",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const Spacer(),

                // ✅ NEXT Button
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (completePhoneNumber.isNotEmpty) {
                        _showConfirmationDialog();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter a number")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A66C2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
