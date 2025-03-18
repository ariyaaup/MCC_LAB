import 'dart:convert';
// import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wngine_app/Function/Factory.dart';

class DeletePage extends StatefulWidget {
  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  void DeletePage() async {
    String _wNgineID = wNgineID.text;

    int intValue = int.tryParse(_wNgineID) ?? 0;
    String url = "http://10.0.2.2:3000/wngine/deleteWngine";
    String json = jsonEncode(
      {
        "wNgineID": intValue,
      },
    );
    var response = await http.delete(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Success Delete Data!')));
      Navigator.pushNamed(context, '/adminPage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to Delete Data!')));
    }
  }

  TextEditingController wNgineID = TextEditingController();
  // String _wNgineID = wNgineID.text;

  // int intValue = int.tryParse(_wNgineID) ?? 0;
  // int _wNgineID = wNgineID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(100, 30, 30, 30),
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/adminPage');
              },
              child: Image.asset(
                "lib/assets/prev.png",
                width: 30,
                height: 30,
                color: const Color.fromARGB(255, 93, 93, 93),
              ),
            ),
            const SizedBox(width: 120),
            Image.asset(
              "lib/assets/W-Engine.png",
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 5,
            ),
            const Text(
              'DELETE',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.red,
                fontSize: 20,
                // fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/W-Engine.png'),
              const SizedBox(height: 20),
              //..........................W ngine Id................................
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: wNgineID,
                  style: const TextStyle(),
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
                    hintText: 'W-EngineID',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  DeletePage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 179, 18, 144),
                  foregroundColor: Colors.white,
                  shadowColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Text("DELETE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
