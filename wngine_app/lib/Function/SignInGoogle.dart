import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:wngine_app/Page/HomePage.dart';

void signInGoogle(BuildContext context) async {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  // Performs Sign In, will return user account's info
  final GoogleSignInAccount? account = await _googleSignIn.signIn();

  // Account will be null if user cancelled the sign-in process
  if (account != null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Successfully signed in')));

    print('Email user: ${account.email}');
    print('Nama user: ${account.displayName}');

    // Send data to the backend
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/login/googleLogin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': account.email,
        'displayName': account.displayName,
      }),
    );

    if (response.statusCode == 200) {
      print('Login data sent to server successfully');
    } else {
      print('Failed to send login data to server: ${response.body}');
    }

    // Navigate to HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Sign-in cancelled')));
  }
}

void signOutGoogle(BuildContext context) async {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  if (await _googleSignIn.isSignedIn()) {
    await _googleSignIn.signOut();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Successfully signed out')));
  }
}
