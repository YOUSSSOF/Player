import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_test/bindings/bindings.dart';
import 'package:music_test/colors.dart';
import 'package:music_test/screens/splash_screen.dart';

void main()async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Palette.primary,
        backgroundColor: const Color(0xFF1F1F1F),
        scaffoldBackgroundColor: const Color(0xFF1F1F1F),
        fontFamily: 'Gotham',
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: MyBindings(),
      home: const SplashScreen(),
    );
  }
}
