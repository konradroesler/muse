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
