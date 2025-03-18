import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  // Menerima beberapa parameter yang dibutuhkan oleh RefreshIndicator
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  Future<void> _refresh() async {
    await Future.delayed(
        Duration(seconds: 2)); // Simulasi refresh dengan delay 2 detik
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 10,
      displacement: 200,
      strokeWidth: 1,
      color: Colors.grey,
      backgroundColor: Colors.black,
      onRefresh: _refresh, // Menjalankan fungsi onRefresh yang diberikan
      child: child, // Konten yang akan di-refresh
    );
  }
}

// Fungsi yang di-trigger saat pengguna melakukan pull-to-refresh
