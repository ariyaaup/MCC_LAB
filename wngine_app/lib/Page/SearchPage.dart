import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wngine_app/Function/Factory.dart';
import 'package:wngine_app/Page/Navigations.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> categories = [
    'lib/assets/attGun.png',
    'lib/assets/anomalyGun.png',
    'lib/assets/stunGun.png',
    'lib/assets/supportGun.png',
    'lib/assets/deffGun.png',
  ];
  int _selectedIndex = 0;
  List<Wngine> searchResults = [];
  String searchQuery = '';

  Future<List<Wngine>> searchFunction(String query) async {
    // API endpoint untuk search
    String url = "http://10.0.2.2:3000/wngine/search?q=${query.trim()}";

    try {
      var resp = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (resp.statusCode == 200) {
        var result = jsonDecode(resp.body);
        List<Wngine> wngineList =
            result.map<Wngine>((item) => Wngine.fromJson(item)).toList();
        return wngineList;
      } else {
        print("Error: ${resp.statusCode}");
        return [];
      }
    } catch (e) {
      print("Search Function Error: $e");
      return [];
    }
  }

  void _onSearchChanged(String query) async {
    setState(() {
      searchQuery = query;
    });

    if (query.isNotEmpty) {
      var results = await searchFunction(query);
      setState(() {
        searchResults = results;
      });
    } else {
      setState(() {
        searchResults = [];
      });
    }
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
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(100, 30, 30, 30),
              Color.fromARGB(100, 250, 174, 216),
              Color.fromARGB(100, 243, 97, 175),
              Color.fromRGBO(42, 42, 42, 0.992),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            // Search Widget
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 50, 50, 50),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),

            // Horizontal ListView
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.15),
                    child: GestureDetector(
                      onTap: () {
                        // Optional: Handle category-based search
                      },
                      child: Image.asset(
                        categories[index],
                        width: 130,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Search Results
            Expanded(
              child: searchResults.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 3 / 5,
                      ),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        var e = searchResults[index];
                        return Card(
                          color: const Color.fromARGB(128, 2, 2, 2),
                          shadowColor: const Color.fromARGB(255, 255, 0, 195),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
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
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      base64Decode(e.gun_image),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  e.name,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "No results found",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ),
            ),
            Container(
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
                            content: Text(
                                'Cart feature is comming soon!'), //ngejar waktu
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/homePage');
                          },
                        ),
                        Container(width: 100.0),
                        IconButton(
                          icon: const Icon(Icons.search_rounded),
                          color: Colors.white,
                          onPressed: () {
                            SearchPage();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
