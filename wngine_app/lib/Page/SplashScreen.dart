import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wngine_app/Page/UsernamePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Simulating the loading progress
    Future.delayed(const Duration(seconds: 1), () {
      // Start loading progress over 2 seconds
      _simulateProgress();
    });
  }

  // Simulate the progress of the loading bar
  void _simulateProgress() async {
    while (_progress < 1.0) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _progress += 0.05; // Increment the progress by 5% every 100ms
      });
    }
    // Navigate to the next page after loading is complete
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RegisterPage()),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(100, 30, 30, 30), // awal
              Color.fromARGB(100, 250, 174, 216), // tengah
              Color.fromARGB(100, 243, 97, 175), // akhir
            ],
            begin: Alignment.topLeft, // Titik awal gradient
            end: Alignment.bottomRight, // Titik akhir gradient
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: screenWidth * 0.5),
            Image.asset('lib/assets/W-Engine.png'),
            SizedBox(height: screenHeight * 0.02),
            const Text(
              'PLEASE WELCOME',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            // LinearProgressIndicator as the loading bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white30,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(100, 243, 97, 175),
                ),
                minHeight: 10, // Adjust the height of the progress bar
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            const Text(
              'Loading...',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
