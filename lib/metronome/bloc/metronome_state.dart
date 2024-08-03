part of 'metronome_bloc.dart';

sealed class MetronomeState extends Equatable {
  const MetronomeState(this.tempo, this.tick);
  final double tempo;
  final int tick;

  @override 
  List<Object> get props => [tempo, tick];
}

final class MetronomeOff extends MetronomeState {
  const MetronomeOff(super.tempo, super.tick);

  @override 
  String toString() => 'MetronomePause { tempo: $tempo, tick: $tick }';
}

final class MetronomeOn extends MetronomeState {
  const MetronomeOn(super.tempo, super.tick);

  @override
  String toString() => 'MetronomeRun { tempo: $tempo, tick: $tick }';
}
