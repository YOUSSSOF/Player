import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_test/screens/albums_screen.dart';
import 'package:music_test/screens/home_screen.dart';
import 'package:music_test/screens/playlists_screen.dart';

enum BottomNavigatorIndex {
  home,
  playlist,
  artists,
}

class BottomNavigatorController extends GetxController {
  var index = 0.obs;
  var homeController = ScrollController().obs;
  var playlistController = ScrollController().obs;
  var exploreController = ScrollController().obs;

  var routes = [
    HomeScreen(),
    AlbumsScreen(),
    PlayListsScreen(),
    Container()
  ].obs;
  void changeIndex(int index) => this.index.value = index;
  void scrollToTop(BottomNavigatorIndex bottomNavigatorIndex) {
    switch (bottomNavigatorIndex) {
      case BottomNavigatorIndex.home:
        homeController.value.animateTo(0,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
        break;
      case BottomNavigatorIndex.playlist:
        playlistController.value.animateTo(0,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
        break;
      case BottomNavigatorIndex.artists:
        exploreController.value.animateTo(0,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
        break;
    }
  }
}
