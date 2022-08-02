import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_test/colors.dart';
import 'package:music_test/controllers/bottom_navigator_controller.dart';
import 'package:music_test/controllers/current_music_controller.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/screens/music_detail_screen.dart';
import 'package:music_test/widgets/music_item.dart';
import 'package:music_test/widgets/my_app_bar.dart';
import 'package:music_test/widgets/recently_played_songs.dart';
import 'package:music_test/widgets/search_box.dart';
import 'package:music_test/widgets/sort_bottom_sheet.dart';
import 'package:music_test/widgets/text_icon_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final MusicController musicController = Get.find<MusicController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: Get.find<BottomNavigatorController>().homeController.value,
      physics: const ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyAppBar(
            text: 'Recently Played',
            icon: 'assets/recent.svg',
          ),
          RecentlyPlayedSongs(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextIconButton(
                text: 'Shuffle',
                icon: 'assets/shuffle.svg',
                onTap: () => Get.find<CurrentMusicController>().shuffle(),
              ),
              SearchBox(
                onChanged: (value) {},
              ),
              TextIconButton(
                text: 'Sort by',
                icon: 'assets/sort.svg',
                onTap: () {
                  Get.bottomSheet(
                    const SortBottomSheet(),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Get.find<CurrentMusicController>().isPlaying.value
                ? Container(
                    height: 120,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Palette.primary,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () =>
                              Get.find<CurrentMusicController>().pause(),
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              Get.find<CurrentMusicController>().play(),
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(MusicDetail()),
                          child: QueryArtworkWidget(
                            id: Get.find<CurrentMusicController>().artId.value,
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(0),
                            artworkWidth: 120,
                            artworkHeight: 120,
                            artworkQuality: FilterQuality.high,
                            nullArtworkWidget: Image.asset(
                              'assets/null.png',
                              fit: BoxFit.cover,
                              height: 143,
                              width: 143,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              Get.find<CurrentMusicController>().shuffle(),
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              Get.find<CurrentMusicController>().shuffle(),
                          icon: const Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
          GetBuilder<MusicController>(
            builder: (_) {
              return musicController.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: musicController.songs.length,
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) => index == 0
                          ? Container()
                          : MusicItem(
                              song: musicController.songs[index],
                            ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
