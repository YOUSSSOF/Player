import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_test/controllers/current_music_controller.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/controllers/playlist_controller.dart';
import 'package:music_test/screens/music_detail_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_test/colors.dart';

class MusicItem extends StatelessWidget {
  const MusicItem({
    Key? key,
    required this.song,
  }) : super(key: key);

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<CurrentMusicController>().setInfo(song),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Palette.primary,
            width: 1,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(10),
                    artworkWidth: 70,
                    artworkHeight: 70,
                    nullArtworkWidget: Image.asset(
                      'assets/null.png',
                      fit: BoxFit.contain,
                      height: 70,
                      width: 70,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          song.title,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          song.artist ?? 'Unknown artist',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: '',
                    backgroundColor: Colors.transparent,
                    content: Align(
                      alignment: Alignment.centerRight,
                      child: Menu(song: song),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Palette.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
    required this.song,
  }) : super(key: key);

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuItem(
          text: 'Share',
          icon: Icons.share,
          border: const [20, 3, 3, 3],
          onPress: () => Get.find<MusicController>().share(song.data),
        ),
        MenuItem(
          text: 'Add to Playlist',
          icon: Icons.playlist_add,
          border: const [3, 3, 3, 3],
          onPress: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(10.0),
                  content: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF1F1F1F),
                    ),
                    width: 200,
                    height: 300,
                    child: Get.find<PlayListController>().playlists.isEmpty
                        ? const Center(
                            child: Text(
                              'No plays list',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            padding: const EdgeInsets.all(4.0),
                            crossAxisSpacing: 4.0,
                            children:
                                Get.find<PlayListController>().playlists.map(
                              (playlist) {
                                return GestureDetector(
                                  onTap: () => Get.find<PlayListController>()
                                      .addToPLaylist(playlist.id, song),
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.2),
                                    ),
                                    child: Center(
                                      child: GridTile(
                                        child: Text(
                                          playlist.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                  ),
                  actions: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Palette.primary),
                          ),
                          onPressed: () {
                            Get.back();
                          }),
                    )
                  ],
                ),
              );
            });
            Get.back();
          },
        ),
        MenuItem(
          text: 'Delete',
          icon: Icons.delete,
          border: const [3, 3, 3, 20],
          color: const Color(0xFFE95555),
          onPress: () => Get.find<MusicController>().deleteSong(song),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.text,
    required this.icon,
    this.color = Colors.white,
    required this.border,
    required this.onPress,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Color color;
  final List<double> border;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 3),
        ),
      ),
      onPressed: onPress,
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(border[0]),
            topRight: Radius.circular(border[1]),
            bottomLeft: Radius.circular(border[2]),
            bottomRight: Radius.circular(border[3]),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Icon(
              icon,
              size: 28,
              color: Colors.black,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
