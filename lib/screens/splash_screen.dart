import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/controllers/playlist_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Get.find<MusicController>().musicInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitSpinningLines(
        color: Colors.yellow,
        size: 250,
      ),
    );
  }
}
