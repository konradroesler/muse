part of 'metronome_bloc.dart';

sealed class MetronomeEvent {
  const MetronomeEvent();
}

final class MetronomeTurnedOn extends MetronomeEvent {
  const MetronomeTurnedOn();
}

final class MetronomeTurnedOff extends MetronomeEvent {
  const MetronomeTurnedOff();
}

final class MetronomeTempoChanged extends MetronomeEvent {
  const MetronomeTempoChanged({required this.tempo});
  final double tempo;
}

final class _MetronomeTicked extends MetronomeEvent {
  const _MetronomeTicked({required this.tick});
  final int tick;
}

final class MetronomeTempoIncrement extends MetronomeEvent {
  const MetronomeTempoIncrement();
}

final class MetronomeTempoDecrement extends MetronomeEvent {
  const MetronomeTempoDecrement();
}
