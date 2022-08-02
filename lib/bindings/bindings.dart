import 'package:get/get.dart';
import 'package:music_test/controllers/bottom_navigator_controller.dart';
import 'package:music_test/controllers/current_music_controller.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/controllers/playlist_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MusicController>(MusicController());
    Get.put<BottomNavigatorController>(BottomNavigatorController());
    Get.put<PlayListController>(PlayListController());
    Get.put<CurrentMusicController>(CurrentMusicController());
  }
}
