import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List<String> imageList = [
    'lib/assets/Hiu.png',
    "lib/assets/TheRestrined.png",
    "lib/assets/StarlightEngineRep.png",
    "lib/assets/BashFullDemon.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200, // Tinggi carousel
                    autoPlay: true, // Mengaktifkan autoplay
                    enlargeCenterPage: true, // Memperbesar gambar di tengah
                    aspectRatio: 16 / 9, // Rasio aspek
                    onPageChanged: (index, reason) {
                      // Tindakan saat halaman berubah
                    },
                  ),
                  items: imageList
                      .map((item) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                item,
                                fit: BoxFit.cover,
                                width: 1000,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
