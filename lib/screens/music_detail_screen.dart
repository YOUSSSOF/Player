import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/widgets/my_bottom_navigation.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_test/controllers/current_music_controller.dart';

class MusicDetail extends StatelessWidget {
  MusicDetail({
    Key? key,
  }) : super(key: key);
  final CurrentMusicController current = Get.find<CurrentMusicController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                  current.title.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Opacity(
                opacity: .75,
                child: Obx(
                  () => Text(
                    current.artist.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              Obx(
                () => QueryArtworkWidget(
                  artworkFit: BoxFit.fill,
                  id: current.artId.value,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(10),
                  artworkWidth: Get.width - 40,
                  artworkHeight: Get.width - 40,
                  nullArtworkWidget: Image.asset(
                    'assets/null.png',
                    fit: BoxFit.cover,
                    height: 143,
                    width: 143,
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 43),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Item(
                      icon: Icons.favorite_outline,
                      onPrees: () {},
                    ),
                    Item(
                      icon: Icons.edit_outlined,
                      onPrees: () {},
                    ),
                    Item(
                      icon: Icons.playlist_add,
                      onPrees: () {},
                    ),
                    Item(
                      icon: Icons.share,
                      onPrees: () =>
                          Get.find<MusicController>().share(current.path.value),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 28),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(31, 31, 31, .1),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => current.setMin(),
                      icon: const Icon(
                        Icons.volume_mute,
                        size: 30,
                        color: Color.fromRGBO(31, 31, 31, .7),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Slider(
                          min: 0,
                          max: 1,
                          activeColor: const Color.fromRGBO(31, 31, 31, .7),
                          inactiveColor: const Color.fromRGBO(31, 31, 31, .2),
                          thumbColor: Colors.black,
                          value: current.volume.value,
                          onChanged: (value) => current.setVolume(value),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => current.setMax(),
                      icon: const Icon(
                        Icons.volume_up,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => current.shuffle(),
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  Obx(
                    () => current.isPlaying.value
                        ? IconButton(
                            onPressed: () => current.pause(),
                            icon: const Icon(
                              Icons.pause_rounded,
                              size: 60,
                            ),
                          )
                        : IconButton(
                            onPressed: () => current.play(),
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 60,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  IconButton(
                    onPressed: () => current.shuffle(),
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      size: 50,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(
        color: const Color.fromRGBO(31, 31, 31, .1),
        border: const Border(),
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key? key, required this.onPrees, required this.icon})
      : super(key: key);
  final VoidCallback onPrees;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 30),
      onPressed: onPrees,
    );
  }
}
