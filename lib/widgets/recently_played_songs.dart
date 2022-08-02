import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_test/colors.dart';
import 'package:music_test/controllers/current_music_controller.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedSongs extends StatelessWidget {
  RecentlyPlayedSongs({
    Key? key,
  }) : super(key: key);

  final MusicController musicController = Get.find<MusicController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18, bottom: 18, right: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Palette.primary,
          width: 1,
        ),
      ),
      height: 227,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 19),
        itemCount: musicController.recentlyPlayedSongs.length,
        itemBuilder: (_, index) => index == 0
            ? Container()
            : GestureDetector(
                onTap: () => Get.find<CurrentMusicController>()
                    .setInfo(musicController.recentlyPlayedSongs[index]),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      QueryArtworkWidget(
                        id: musicController.recentlyPlayedSongs[index].id,
                        type: ArtworkType.AUDIO,
                        artworkBorder: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        artworkWidth: 143,
                        artworkHeight: 143,
                        nullArtworkWidget: Image.asset(
                          'assets/null.png',
                          fit: BoxFit.cover,
                          height: 143,
                          width: 143,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          musicController.recentlyPlayedSongs[index].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          musicController.recentlyPlayedSongs[index].artist ??
                              'Unknown artist',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
