import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:music_test/controllers/bottom_navigator_controller.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/screens/music_detail_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CurrentMusicController extends GetxController {
  final player = AudioPlayer();
  var title = ''.obs;
  var artist = ''.obs;
  var artId = 0.obs;
  var isPlaying = false.obs;
  var path = ''.obs;
  var volume = 0.75.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  void setInfo(SongModel song) {
    title.value = song.title;
    artist.value = song.artist ?? 'Unknown';
    artId.value = song.id;
    path.value = song.data;
    player.setUrl(song.data);
    isPlaying.value = true;
    player.play();
  }



  void play() {
    isPlaying.value = true;
    player.play();
  }

  void pause() {
    isPlaying.value = false;
    player.pause();
  }

  void setVolume(value) {
    volume.value = value;
    player.setVolume(value);
  }

  void setMax() {
    volume.value = 1;
    player.setVolume(1);
  }

  void setMin() {
    volume.value = 0;
    player.setVolume(0);
  }

  void shuffle() async {
    SongModel ranSong = Get.find<MusicController>()
        .songs[Random().nextInt(Get.find<MusicController>().songs.length)];
    setInfo(ranSong);
  }
}
