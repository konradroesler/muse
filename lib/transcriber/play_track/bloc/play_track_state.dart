part of 'play_track_bloc.dart';

enum PlayTrackStatus { initial, playing, paused }

extension PlayTrackStatusX on PlayTrackStatus {
  bool get isPlaying => this == PlayTrackStatus.playing;
}

final class PlayTrackState extends Equatable {
  const PlayTrackState({
    this.status = PlayTrackStatus.initial,
    required this.name,
    required this.id,
    this.progress = 0,
  }); 

  final PlayTrackStatus status;
  final String name;
  final String id;
  final double progress;

  PlayTrackState copyWith({
    PlayTrackStatus? status,
    String? name,
    String? id,
    double? progress,
  }) {
    return PlayTrackState(
      status: status ?? this.status,
      name: name ?? this.name,
      id: id ?? this.id,
      progress: progress ?? this.progress,
    );
  }

  @override 
  List<Object> get props => [status, name, id, progress];
}
