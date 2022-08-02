import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_test/controllers/bottom_navigator_controller.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/controllers/playlist_controller.dart';
import 'package:music_test/widgets/add_play_list.dart';
import 'package:music_test/widgets/my_bottom_navigation.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 19, right: 19),
              child: RefreshIndicator(
                onRefresh: () async =>
                    Get.find<BottomNavigatorController>().index.value == 0
                        ? Get.find<MusicController>().querySongs()
                        : Get.find<PlayListController>().getPlaylists(),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 0),
                  child: SizedBox(
                    child: IndexedStack(
                      index: Get.find<BottomNavigatorController>().index.value,
                      children: Get.find<BottomNavigatorController>().routes,
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar:  MyBottomNavigation(),
          floatingActionButton: Obx(
            () => Get.find<BottomNavigatorController>().index.value == 2
                ? AddToPLayList()
                : Container(),
          ),
        ),
      ),
    );
  }
}
