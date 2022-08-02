import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class Playlist {
   String id;
  List<int> songIds = [];
   String name;
   String? coverPath;
  Playlist({
    required this.name,
    this.coverPath,
  }) : id = uuid.v4();
  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      name: json['name'],
      coverPath: json['coverPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coverPath': coverPath,
      'songIds': songIds,
    };
  }

  @override
  String toString() =>
      'Playlist(id: $id, name: $name, coverPath: $coverPath, songIds: $songIds)';
}
