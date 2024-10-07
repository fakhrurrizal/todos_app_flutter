import 'package:flutter/material.dart';
import 'package:todos_app_flutter/presentation/home/pages/main_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.blue, // AppColors.primary (gunakan warna sesuai)
      body: Column(
        children: [
          const Spacer(),
          // Tambahkan logo di sini jika diperlukan
          const Spacer(),
        ],
      ),
    );
  }
}
