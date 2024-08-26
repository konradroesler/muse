part of 'play_track_bloc.dart';

sealed class PlayTrackEvent extends Equatable {
  const PlayTrackEvent();

  @override 
  List<Object> get props => [];
}

final class PlayPauseButtonPressed extends PlayTrackEvent {
  const PlayPauseButtonPressed();
}

final class ReturnToOverviewButtonPressed extends PlayTrackEvent {
  const ReturnToOverviewButtonPressed();
}

final class AudioPlayerCompleted extends PlayTrackEvent {
  const AudioPlayerCompleted();
}
