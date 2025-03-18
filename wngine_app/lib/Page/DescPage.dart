import 'dart:convert';
// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wngine_app/Function/Factory.dart';
// import 'package:wngine_app/Page/HomePage.dart';
import 'package:wngine_app/Page/Navigations.dart';
// import 'package:wngine_app/Page/SearchPage.dart';

class Descriptions extends StatefulWidget {
  const Descriptions({super.key});

  @override
  State<Descriptions> createState() => _DescriptionsState();
}

class _DescriptionsState extends State<Descriptions> {
  late Wngine item;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    item = ModalRoute.of(context)!.settings.arguments as Wngine;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(100, 30, 30, 30),
        title: Row(
          children: [
            const SizedBox(width: 100),
            Image.asset(
              "lib/assets/W-Engine.png",
              width: 120,
              height: 120,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
              // Menampilkan gambar item yang dipilih
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.memory(
                  base64Decode(item.gun_image),
                  width: 150,
                ),
              ),
              // Menampilkan informasi dalam GridView
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.5,
                  ),
                  children: [
                    _buildGridItem("Name", item.name),
                    _buildGridItem("Price", "\$${item.price}"),
                    _buildGridItem("Rarity", item.rarityGUN),
                    _buildGridItem("Base ATK", item.baseATK.toString()),
                    _buildGridItem("Base ADV Stat", "${item.baseAdvStat}%"),
                    _buildGridItem("Type", item.typeID.toString()),
                    _buildGridItem("Level", item.level.toString()),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  item.description, // Menampilkan deskripsi item
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(122, 0, 0, 0),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Cart feature is coming soon!'), //ngejar waktu
                            ),
                          );
                        },
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Cannot Buy! Buy feature is coming soon'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 179, 18, 144),
                        ),
                        child: const Text('BUY',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
                      content: Text('Cart Page is coming soon!'),
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
                      Navigator.pushNamed(context, '/searchPage');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method untuk membuat item dalam grid
  Widget _buildGridItem(
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
