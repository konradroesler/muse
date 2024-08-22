import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks_repository/tracks_repository.dart';

part 'edit_track_event.dart';
part 'edit_track_state.dart';

class EditTrackBloc extends Bloc<EditTrackEvent, EditTrackState>{
  EditTrackBloc({
    required this.tracksRepository,
    required this.track,
  }) : super(
      EditTrackState(
        track: track,
        name: track.name,
      ),
    ) {
    on<EditTrackNameChanged>(_onNameChanged);
    on<EditTrackSubmitted>(_onSubmitted);
  }

  final TracksRepository tracksRepository;
  final Track track;

  Future<void> _onNameChanged(event, emit) async {
    emit(state.copyWith(name: event.name));
  }

  Future<void> _onSubmitted(event, emit) async {
    emit(state.copyWith(status: EditTrackStatus.loading));
    final track = state.track.copyWith(
      name: state.name,
    ); 

    try {
      await tracksRepository.saveTrack(track);
      emit(state.copyWith(status: EditTrackStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTrackStatus.failure)); 
    }
  }

}

