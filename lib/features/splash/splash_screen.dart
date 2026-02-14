import 'package:flutter/material.dart';
import '../../main.dart'; // Import to navigate to MainScreen (or home)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (mounted) {
      // Navigate to the main screen or login screen
      // For now, we'll just go to a placeholder text screen since we don't have a real home screen yet
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'Caffely'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain, // Ensure logo scales correctly
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Caffely',
                    style: TextStyle(
                      fontSize: 32, // Larger font size for brand name
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Stark black for contrast
                      letterSpacing: 1.5, // Slight spacing for elegance
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const CircularProgressIndicator(
              color: Color(0xFF10B981), // Emerald 600
              strokeWidth: 3,
            ),
            const SizedBox(height: 80), // Position loader from bottom
          ],
        ),
      ),
    );
  }
}
