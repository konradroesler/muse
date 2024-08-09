part of 'tuner_bloc.dart';

sealed class TunerState extends Equatable {
  const TunerState(this.note, this.pitch
  );
  final String note;
  final int pitch;

  @override 
  List<Object> get props => [note, pitch];
}

final class TunerInitial extends TunerState {
  const TunerInitial(super.note, super.pitch);
}

final class TunerIdle extends TunerState {
  const TunerIdle(super.note, super.pitch);
}

final class TunerRecording extends TunerState {
  const TunerRecording(super.note, super.pitch);
}
