import 'package:tracks_api/tracks_api.dart';

abstract class TracksApi {
  const TracksApi();

  Stream<List<Track>> getTracks();

  Future<void> saveTrack(Track track);

  Future<void> deleteTrack(String id);

  Future<void> close();
}

class TrackNotFoundException implements Exception {}
