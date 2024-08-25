import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks_repository/tracks_repository.dart';

part 'play_track_event.dart';
part 'play_track_state.dart';

class PlayTrackBloc extends Bloc<PlayTrackEvent, PlayTrackState> {
  PlayTrackBloc({
    required this.tracksRepository,
    required this.track,
  }) : super(PlayTrackState(track: track)) {
    on<PlayPauseButtonPressed>(_onPlayPauseButtonPressed);
  }

  Track track;
  final TracksRepository tracksRepository;
  // TODO add audio player

  void _onPlayPauseButtonPressed(event, emit) {
    // TODO implement actual audio player logic
    if (state.status.isPlaying) {
      emit(state.copyWith(status: PlayTrackStatus.paused));
    } else {
      emit(state.copyWith(status: PlayTrackStatus.playing));
    }
  }
}
