import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks_repository/tracks_repository.dart';

part 'play_track_event.dart';
part 'play_track_state.dart';

class PlayTrackBloc extends Bloc<PlayTrackEvent, PlayTrackState> {
  PlayTrackBloc({
    required this.tracksRepository,
    required this.track,
  }) : super(PlayTrackState(track: track));

  final TracksRepository tracksRepository;
  Track track;
}
