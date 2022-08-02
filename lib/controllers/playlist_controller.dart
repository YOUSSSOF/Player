import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_test/models/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListController extends GetxController {
  var playlists = <Playlist>[].obs;
  var box = GetStorage();

  @override
  void onInit() {
    getPlaylists();
    ever(playlists, (value) {
      box.write('playlists', playlists.toJson());
    });
    super.onInit();
  }

  void getPlaylists() {
    if (box.read('playlists') != null) {
      var list = box.read('playlists');
      for (var item in list) {
        playlists.add(Playlist.fromJson(item));
      }
    }
  }

  void createPlaylist(String name) {
    playlists.add(Playlist(
      name: name,
    ));
  }

  void removePlaylist(Playlist playlist) {
    playlists.remove(playlist);
  }

  void setPlaylistCover() {}

  void addToPLaylist(String playlistId, SongModel song) async {
    playlists[playlists.indexWhere((p) => p.id == playlistId)]
        .songIds
        .add(song.id);


    Get.back();
  }

  void removeFromPlaylist(Playlist playlist) {
    playlists.remove(playlist);
  }

  void editPlayList(int index) {}
}
