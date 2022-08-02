import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_test/colors.dart';
import 'package:music_test/controllers/bottom_navigator_controller.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/widgets/my_app_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumsScreen extends StatelessWidget {
  AlbumsScreen({Key? key}) : super(key: key);
  final MusicController musicController = Get.find<MusicController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: Get.find<BottomNavigatorController>().exploreController.value,
      child: Column(
        children: [
          const MyAppBar(
            text: 'Albums',
            icon: 'assets/explore.svg',
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 19.0,
              mainAxisSpacing: 19.0,
            ),
            itemCount: musicController.albums.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () => {},
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      QueryArtworkWidget(
                        id: musicController.albums[index].id,
                        type: ArtworkType.ALBUM,
                        artworkBorder: BorderRadius.circular(10),
                        artworkWidth: 200,
                        artworkHeight: 200,
                      ),
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                musicController.albums[index].album,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 1.0,
                                      offset: Offset(1.0, 1.0),
                                    ),
                                  ],
                                  height: 1.5,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
