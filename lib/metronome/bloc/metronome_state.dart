part of 'metronome_bloc.dart';

sealed class MetronomeState extends Equatable {
  const MetronomeState(this.tempo, this.tick);
  final double tempo;
  final int tick;

  @override 
  List<Object> get props => [tempo, tick];
}

final class MetronomeInitial extends MetronomeState {
  const MetronomeInitial(super.tempo, super.tick);

  @override 
  String toString() => 'MetronomeInitial { tempo: $tempo, tick: $tick }';
}

final class MetronomePause extends MetronomeState {
  const MetronomePause(super.tempo, super.tick);

  @override 
  String toString() => 'MetronomePause { tempo: $tempo, tick: $tick }';
}

final class MetronomeRun extends MetronomeState {
  const MetronomeRun(super.tempo, super.tick);

  @override
  String toString() => 'MetronomeRun { tempo: $tempo, tick: $tick }';
}
