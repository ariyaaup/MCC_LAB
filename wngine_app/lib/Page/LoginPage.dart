import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wngine_app/Function/SharedPreferences.dart';
import 'dart:convert';

import 'package:wngine_app/Function/SignInGoogle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  // Fungsi login ke server dan menyimpan username ke SharedPreferences
  void login() async {
    String url = "http://10.0.2.2:3000/login/Login";
    String jsonBody =
        jsonEncode({"username": username.text, "password": password.text});

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonBody);

    if (response.statusCode == 200) {
      // Check if admin credentials are used
      if (username.text == 'admin' && password.text == 'admin123') {
        // Navigate to AdminPage
        Navigator.pushNamed(context, '/adminPage');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Welcome, Admin!')),
        );
      } else {
        // Login berhasil untuk user biasa
        await UserPreference.saveUsername(username.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome, ${username.text}!')),
        );
        Navigator.pushNamed(context, '/homePage');
      }
    } else {
      // Login gagal: Tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to Login')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(100, 30, 30, 30), // Awal
              Color.fromARGB(100, 250, 174, 216), // Tengah
              Color.fromARGB(100, 243, 97, 175), // Akhir
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Image.asset('lib/assets/W-Engine.png'),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: username,
                    style: const TextStyle(fontFamily: 'Poppins'),
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF777777),
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF333333),
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: const Color(0xFFFFFFFF),
                      filled: true,
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: password,
                    style: const TextStyle(fontFamily: 'Poppins'),
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF777777),
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF333333),
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: const Color(0xFFFFFFFF),
                      filled: true,
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    "Sign IN",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                const Text(
                  'Or sign in With',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                    icon: Image.asset(
                      'lib/assets/google.png',
                      color: Colors.black,
                      height: 35,
                      width: 35,
                    ),
                    onPressed: () {
                      signInGoogle(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
