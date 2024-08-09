part of 'tuner_bloc.dart';

sealed class TunerEvent extends Equatable {
  const TunerEvent();

  @override 
  List<Object> get props => [];
}

final class TunerRecordingStarted extends TunerEvent {
  const TunerRecordingStarted();
}

final class TunerRecordingEnded extends TunerEvent {
  const TunerRecordingEnded();
}

final class _TunerPitchChanged extends TunerEvent {
  const _TunerPitchChanged(this.note, this.pitch);
  final String note;
  final int pitch;
}
