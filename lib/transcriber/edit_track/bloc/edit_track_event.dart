part of 'edit_track_bloc.dart';

sealed class EditTrackEvent extends Equatable {
  const EditTrackEvent();

  @override 
  List<Object> get props => [];
}

final class EditTrackNameChanged extends EditTrackEvent {
  const EditTrackNameChanged(this.name);

  final String name;

  @override 
  List<Object> get props => [name];
}

final class EditTrackSubmitted extends EditTrackEvent {
  const EditTrackSubmitted();
}
