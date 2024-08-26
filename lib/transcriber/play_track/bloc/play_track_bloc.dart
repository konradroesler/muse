import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:tracks_repository/tracks_repository.dart';
import 'package:utils/utils.dart';

part 'play_track_event.dart';
part 'play_track_state.dart';

class PlayTrackBloc extends Bloc<PlayTrackEvent, PlayTrackState> {
  PlayTrackBloc({
    required this.tracksRepository,
    required this.track,
  }) : super(PlayTrackState(track: track)) {
    on<PlayPauseButtonPressed>(_onPlayPauseButtonPressed);
    on<ReturnToOverviewButtonPressed>(_onReturnToOverviewButtonPressed);
  }

  Track track;
  final TracksRepository tracksRepository;
  final AudioPlayer audioPlayer = AudioPlayer();

  void _onPlayPauseButtonPressed(event, emit) async {
    switch (state.status) {
      case PlayTrackStatus.initial : {
        final audioFileLocation = '${join(await utilsGetDatabasePath(), track.id)}.${await getCorrectFileExtension(track.id)}';
        await audioPlayer.play(DeviceFileSource(audioFileLocation));
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

  void _onReturnToOverviewButtonPressed(event, emit) async {
    if (state.status.isPlaying) {
      await audioPlayer.pause();
    }
    await audioPlayer.dispose();
  }
}
