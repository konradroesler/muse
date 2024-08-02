part of 'metronome_bloc.dart';

sealed class MetronomeEvent {
  const MetronomeEvent();
}

final class MetronomeStarted extends MetronomeEvent {
  const MetronomeStarted();
}

final class MetronomePaused extends MetronomeEvent {
  const MetronomePaused();
}

final class MetronomeResumed extends MetronomeEvent {
  const MetronomeResumed();
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
