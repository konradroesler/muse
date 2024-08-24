part of 'play_track_bloc.dart';

sealed class PlayTrackState extends Equatable {
  const PlayTrackState(); 

  @override 
  List<Object> get props => [];
}

final class PlayTrackInitial extends PlayTrackState {
  const PlayTrackInitial();
}
