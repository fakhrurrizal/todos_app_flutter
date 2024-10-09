import 'package:flutter/material.dart';
import 'package:todos_app_flutter/pages/main_page.dart';

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
    return const Scaffold(
      backgroundColor: Colors.blue, 
      body:  Column(
        children: [
           Spacer(),
          // Tambahkan logo di sini jika diperlukan
           Spacer(),
        ],
      ),
    );
  }
}
