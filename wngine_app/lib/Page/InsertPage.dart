import 'dart:convert';
// import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InsertAdmin extends StatefulWidget {
  const InsertAdmin({super.key});

  @override
  State<InsertAdmin> createState() => _InsertAdminState();
}

class _InsertAdminState extends State<InsertAdmin> {
  void InsertPage() async {
    String url = "http://10.0.2.2:3000/wngine/insert";
    String json = jsonEncode(
      {
        "name": name.text,
        "price": price.text,
        "rarityGUN": rarityGUN.text,
        "baseATK": baseATK.text,
        "baseAdvStat": baseAdvStat.text,
        "description": description.text,
        "typeID": typeID.text,
        "level": level.text,
        "gun_image": gun_image
      },
    );
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json);
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/adminPage');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to register')));
    }
  }

  var name = TextEditingController();
  var price = TextEditingController();
  var rarityGUN = TextEditingController();
  var baseATK = TextEditingController();
  var baseAdvStat = TextEditingController();
  var description = TextEditingController();
  var typeID = TextEditingController();
  var level = TextEditingController();
  Uint8List? gun_image;

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
            const SizedBox(width: 150),
            Image.asset(
              "lib/assets/W-Engine.png",
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 5,
            ),
            const Text(
              'Insert',
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
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //--------------   image picker tombol  -----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        var pickedImage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedImage != null) {
                          var imagesBytes = await pickedImage.readAsBytes();
                          setState(() {
                            gun_image = imagesBytes;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(100, 243, 97, 175),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(20),
                      ),

                      // -------------------------------- icon insert gambar--------------------------------
                      child: const Row(
                        children: [
                          Icon(
                            Icons.camera_alt, // Ikon kamera
                            size: 24, // Ukuran ikon
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Insert W-Engine Picture',
                            style: TextStyle(
                              fontSize: 16, // Ukuran teks,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                //--------------------- NAME GUN ------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: name,
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
                      hintText: 'Name Gun',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //--------------------------- PRICE ----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: price,
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
                      hintText: 'Price',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //--------------------------- RARITY GUN ----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: rarityGUN,
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
                      hintText: 'Rarity',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //--------------------------- BASE ATK ----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: baseATK,
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
                      hintText: 'Base Attack',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //--------------------------- BASE ADV STAT ----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: baseAdvStat,
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
                      hintText: 'Base Adv. Stat',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //--------------------------- Description ----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: description,
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
                      hintText: 'Description',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //--------------------------- typeID ----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: typeID,
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
                      hintText: 'typeID',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //--------------------------- LEVEL ----------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: level,
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
                      hintText: 'Level',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    InsertPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 179, 18, 144),
                    foregroundColor: Colors.white,
                    shadowColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: const Text("INSERT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
