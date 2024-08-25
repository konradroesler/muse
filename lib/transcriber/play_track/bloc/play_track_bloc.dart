import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks_repository/tracks_repository.dart';

part 'play_track_event.dart';
part 'play_track_state.dart';

class PlayTrackBloc extends Bloc<PlayTrackEvent, PlayTrackState> {
  PlayTrackBloc({
    required this.tracksRepository,
    required this.track,
  }) : super(PlayTrackState(name: track.name, id: track.id)) {
    on<PlayPauseButtonPressed>(_onPlayPauseButtonPressed);
  }

  Track track;
  final TracksRepository tracksRepository;
  final AudioPlayer audioPlayer = AudioPlayer();

  void _onPlayPauseButtonPressed(event, emit) async {
    // TODO implement actual audio player logic
    switch (state.status) {
      case PlayTrackStatus.initial : {
        // CRITICAL DOES NOT WORK
        await audioPlayer.play(BytesSource(track.file));
        emit(state.copyWith(status: PlayTrackStatus.playing));
      }
      case PlayTrackStatus.playing : {
        await audioPlayer.pause();
        emit(state.copyWith(status: PlayTrackStatus.paused));
      }
      case PlayTrackStatus.paused : {
        await audioPlayer.resume();
        emit(state.copyWith(status: PlayTrackStatus.playing));
      }
    }
  }
}
