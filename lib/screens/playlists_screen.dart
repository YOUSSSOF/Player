import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_test/colors.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/controllers/playlist_controller.dart';
import 'package:music_test/widgets/my_app_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListsScreen extends StatelessWidget {
  PlayListsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyAppBar(
            text: 'Playlists',
            icon: 'assets/playlist.svg',
          ),
          Obx(
            () => Get.find<PlayListController>().playlists.isEmpty
                ? const Center(
                    child: Text('No playlist yet'),
                  )
                : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 19.0,
                      mainAxisSpacing: 19.0,
                    ),
                    itemCount: Get.find<PlayListController>().playlists.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () =>
                            Get.find<PlayListController>().removePlaylist(
                          Get.find<PlayListController>().playlists[index],
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      Get.find<PlayListController>()
                                          .playlists[index]
                                          .name,
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        height: 1.5,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: const Icon(Icons.settings,
                                        color: Palette.primary),
                                    onPressed: () =>
                                        Get.find<PlayListController>()
                                            .editPlayList(0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
