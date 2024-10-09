import 'package:flutter/material.dart';
import 'package:todos_app_flutter/core/constants/colors.dart';
import 'package:todos_app_flutter/pages/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        dividerTheme: DividerThemeData(color: AppColors.light.withOpacity(0.5)),
        dialogTheme: const DialogTheme(elevation: 0),
        // textTheme: GoogleFonts.kumbhSansTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: AppColors.white,
          elevation: 0,
          // titleTextStyle: GoogleFonts.kumbhSans(
          //   color: AppColors.black,
          //   fontSize: 24.0,
          //   fontWeight: FontWeight.bold,
          // ),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
