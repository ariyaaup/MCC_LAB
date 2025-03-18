//projek ini dibuat sekitar November 2024, dan dikumpulkan 18 Dec 2024, 07:56:05

import 'dart:convert';
// import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wngine_app/Function/Factory.dart';
// import 'package:wngine_app/Page/InsertPage.dart';
import 'package:wngine_app/Page/ImageCarousel.dart';
import 'package:wngine_app/Page/Drawer.dart';
import 'package:http/http.dart' as http;
import 'package:wngine_app/Page/Navigations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late Future<List<Wngine>> wngineList;

  Future<List<Wngine>> fetchwngine() async {
    String url = "http://10.0.2.2:3000/wngine/display";
    // var token = AuthService.loggedUser!.token;
    // ignore: avoid_print
    // print(token);
    var resp = await http.get(Uri.parse(url));
    var result = jsonDecode(resp.body);

    List<Wngine> wngineList = [];

    for (var i in result) {
      Wngine fetchwngine = Wngine.fromJson(i);
      wngineList.add(fetchwngine);
    }

    return wngineList;
  }

  Future<void> _refresh() async {
    setState(() {
      wngineList = fetchwngine(); // Memuat ulang data dari API
    });
  }

  @override
  void initState() {
    wngineList = fetchwngine();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(100, 30, 30, 30),
        title: Row(
          children: [
            Image.asset(
              "lib/assets/W-Engine.png",
              width: 120,
              height: 120,
            ),
            const SizedBox(width: 5),
            const Text(
              'STORE',
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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(100, 30, 30, 30),
                Color.fromARGB(100, 250, 174, 216),
                Color.fromARGB(100, 243, 97, 175),
                Color.fromRGBO(42, 42, 42, 0.992),
              ],
              begin: Alignment.topLeft, // Titik awal gradient
              end: Alignment.bottomLeft, // Titik akhir gradient
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 200,
                    child: ImageCarousel(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    child: Column(
                      children: [
                        Text(
                          'Items',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: wngineList,
                    builder: (context, snapshot) {
                      var DisplayData = snapshot.data;
                      if (DisplayData != null) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3 / 4, // Sesuaikan aspek rasio
                            ),
                            itemCount: DisplayData.length,
                            itemBuilder: (context, index) {
                              var e = DisplayData[index];
                              return Card(
                                color: const Color.fromARGB(128, 2, 2, 2),
                                shadowColor:
                                    const Color.fromARGB(255, 255, 0, 195),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/descriptions',
                                            arguments: e,
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            base64Decode(e.gun_image),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        e.name,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Text(
                          "No Data Available",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: 500,
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: const Size(500, 80),
              painter: TesCustomePainter(),
            ),
            Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Cart feature is comming soon!'), //ngejar waktu
                    ),
                  );
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.shopping_basket),
                elevation: 0.1,
              ),
            ),
            Container(
              width: 500,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  Container(width: 100.0),
                  IconButton(
                    icon: const Icon(Icons.search_rounded),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/searchPage');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: DrawerMenu(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
