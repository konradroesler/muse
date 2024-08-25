part of 'play_track_bloc.dart';

enum PlayTrackStatus { initial, playing, paused }

extension PlayTrackStatusX on PlayTrackStatus {
  bool get isPlaying => this == PlayTrackStatus.playing;
}

final class PlayTrackState extends Equatable {
  const PlayTrackState({
    this.status = PlayTrackStatus.initial,
    required this.track,
    this.progress = 0,
  }); 

  final PlayTrackStatus status;
  final Track track;
  final double progress;

  PlayTrackState copyWith({
    PlayTrackStatus? status,
    Track? track,
    double? progress,
  }) {
    return PlayTrackState(
      status: status ?? this.status,
      track: track ?? this.track,
      progress: progress ?? this.progress,
    );
  }

  @override 
  List<Object> get props => [status, track, progress];
}
