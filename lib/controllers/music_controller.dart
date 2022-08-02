import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_test/screens/main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class MusicController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  var songs = <SongModel>[].obs;
  var playlists = <PlaylistModel>[].obs;
  var recentlyPlayedSongs = <SongModel>[].obs;
  var albums = <AlbumModel>[].obs;
  var sortType = SongSortType.ARTIST.obs;
  var loading = false.obs;

  void musicInit() async {
    loading.value = true;
    queryAlbums();
    await querySongs();
    queryRecent();
    super.onInit();
    loading.value = false;
  }

  Future<void> querySongs() async {
    bool isPermitted = await _audioQuery.permissionsStatus();
    if (!isPermitted) {
      await _audioQuery.permissionsRequest();
    }
    songs.value = await _audioQuery.querySongs(
      sortType: SongSortType.TITLE,
    );
    loading.value = false;
    Get.offAll(const Main());
  }

  void queryRecent() {
    final random = Random();
    for (int i = 0; i <= 6; i++) {
      SongModel song = songs[random.nextInt(songs.length)];
      recentlyPlayedSongs.add(song);
    }
  }

  void queryAlbums() async {
    albums.value = await _audioQuery.queryAlbums();
  }

  void changeOrder({required SongSortType sort}) async {
    sortType.value = sort;
    songs.value = await _audioQuery.querySongs(
      sortType: sort,
    );
    update();
    Get.back();
  }

  void search(String query) async {
    loading.value = true;
    if (query.trim().isNotEmpty) {
      songs.value = songs
          .where(
              (song) => song.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      songs.value = await _audioQuery.querySongs();
    }
    loading.value = false;
    update();
  }

  void deleteSong(SongModel song) async {
    try {
      // final root = await getApplicationDocumentsDirectory();
      final path = song.data;
      File(path).delete();
    } catch (e) {
      Get.snackbar('Can\'t delete this file', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10));
    }
    update();
  }

  void share(String path) async {
    if (!await Permission.manageExternalStorage.request().isGranted) {
      await Permission.manageExternalStorage.request();
    }
    await Share.shareFiles([path]);
    Get.back();
  }
}
