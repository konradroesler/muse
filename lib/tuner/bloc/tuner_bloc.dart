import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tuner_event.dart';
part 'tuner_state.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState> {
  TunerBloc() : super(const TunerInitial()) {
    on<TunerRecordingStarted>(_onRecordingStarted);
    on<TunerRecordingEnded>(_onRecordingEnded);
  }

  void _onRecordingStarted(event, emit) {
    emit(TunerRecording());
  }

  void _onRecordingEnded(event, emit) {
    emit(TunerIdle());
  }
}
