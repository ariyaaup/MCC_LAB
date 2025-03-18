import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:wngine_app/Function/SharedPreferences.dart';
import 'dart:convert';

import 'package:wngine_app/Function/SignInGoogle.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void HomePage() async {
    String url = "http://10.0.2.2:3000/login/SignUp";
    String json =
        jsonEncode({"username": username.text, "password": password.text});
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully registered')));
      Navigator.pushNamed(context, '/loginPage');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to register')));
    }
  }

  var username = TextEditingController();
  var password = TextEditingController();

  // Sign in as Guest
  void signAsGuest() async {
    await UserPreference.saveUsername("Guest"); // Simpan status guest
    Navigator.pushNamed(context, '/homePage'); // Pindah ke homePage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(100, 30, 30, 30), //  awal
              Color.fromARGB(100, 250, 174, 216), //tengah
              Color.fromARGB(100, 243, 97, 175), //  akhir
            ],
            begin: Alignment.topLeft, // Titik awal gradient
            end: Alignment.bottomRight, // Titik akhir gradient
          ),
        ),
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset('lib/assets/W-Engine.png'),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: username,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                    ),
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
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: password,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                    ),
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
                        fontFamily: 'Popppins',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    HomePage();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    "Sign UP",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/loginPage');
                  },
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
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: signAsGuest,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    "Sign as a Guest",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
