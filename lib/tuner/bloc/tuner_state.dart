part of 'tuner_bloc.dart';

sealed class TunerState extends Equatable {
  const TunerState();

  @override 
  List<Object> get props => [];
}

final class TunerInitial extends TunerState {
  const TunerInitial();
}

final class TunerIdle extends TunerState {
  const TunerIdle();
}

final class TunerRecording extends TunerState {
  const TunerRecording();
}
