import 'package:sqflite/sqflite.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tracks_api/tracks_api.dart';

class LocalStorageTracksApi extends TracksApi {
  LocalStorageTracksApi({
    required this.database,
  }) {
    _init();
  }
 
  final Database database;

  late final _trackStreamController = BehaviorSubject<List<Track>>.seeded(
    const [],
  );

  void _init() async {
    final result = await database.query('tracks');
    final tracks = result.map((map) => Track.fromMap(map)).toList();
    _trackStreamController.add(tracks);
  }

  @override 
  Stream<List<Track>> getTracks() => _trackStreamController.asBroadcastStream();

  @override 
  Future<void> saveTrack(Track track) async {
    final tracks = [..._trackStreamController.value];
    final trackIndex = tracks.indexWhere((t) => t.id == track.id);
    if (trackIndex >= 0) {
      tracks[trackIndex] = track;
    } else {
      tracks.add(track);
    }
    await database.insert(
      'tracks',
      track.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _trackStreamController.add(tracks);
  }

  @override 
  Future<void> deleteTrack(String id) async {
    final tracks = [..._trackStreamController.value];
    final trackIndex = tracks.indexWhere((t) => t.id == id);
    if (trackIndex == -1) {
      throw TrackNotFoundException();
    } else {
      tracks.removeAt(trackIndex);
      await database.delete(
        'tracks',
        where: 'id = ?',
        whereArgs: [id],
      );
      _trackStreamController.add(tracks);
    }
  }
  
  @override 
  Future<void> close() {
    return _trackStreamController.close();
  }
}
