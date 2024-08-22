import 'package:tracks_api/tracks_api.dart';

class TracksRepository {

  const TracksRepository({
    required this.tracksApi,
  });

  final TracksApi tracksApi;

  Stream<List<Track>> getTracks() => tracksApi.getTracks();

  Future<void> saveTrack(Track track) => tracksApi.saveTrack(track);

  Future<void> deleteTrack(String id) => tracksApi.deleteTrack(id);
}
