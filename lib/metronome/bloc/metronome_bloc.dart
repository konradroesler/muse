import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';
import 'package:equatable/equatable.dart';
import 'package:muse/metronome/metronome_ticker.dart';

part 'metronome_event.dart';
part 'metronome_state.dart';

class MetronomeBloc extends Bloc<MetronomeEvent, MetronomeState> {
  MetronomeBloc() :
    super(const MetronomeInitial(120, 1)) {
    _clock = Ticker(_onTick);
    on<MetronomeStarted>(_onStarted);
    on<MetronomePaused>(_onPaused);
    on<MetronomeResumed>(_onResumed);
    on<MetronomeTempoChanged>(_onTempoChanged);
    on<_MetronomeTicked>(_onTicked);
    on<MetronomeTempoIncrement>(_onTempoIncrement);
    on<MetronomeTempoDecrement>(_onTempoDecrement);
  }

  int _tick = 1;
  double _tempo = 120;

  MetronomeTicker? _ticker;
  StreamSubscription<int>? _tickerSubscription;

  Duration _elapsed = Duration.zero;
  Duration _lastTick = Duration.zero;
  late Ticker _clock;

  void _onTick(Duration elapsed) {
    _elapsed = elapsed;
  }

  @override 
  Future<void> close() {
    _clock.dispose();
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(MetronomeStarted event, Emitter<MetronomeState> emit) {
    // very first Tick
    emit(MetronomeRun(_tempo, _tick));
    // start the clock
    _clock.start();
    // start metronome ticker
    _tickerSubscription?.cancel();
    _ticker = MetronomeTicker(tempo: _tempo);
    _tickerSubscription = _ticker
      ?.tick(tempo: _tempo)
      .listen((tick) => add(_MetronomeTicked(tick: tick)));
  }

  void _onPaused(MetronomePaused event, Emitter<MetronomeState> emit) {
    if (state is MetronomeRun) {
      _clock.stop();
      _tickerSubscription?.pause();
      emit(MetronomePause(_tempo, _tick));
    }
  }

  void _onResumed(MetronomeResumed event, Emitter<MetronomeState> emit) {
    if (state is MetronomePause) {
      _clock.start();
      _tickerSubscription?.resume();
      emit(MetronomeRun(_tempo, _tick));
    }
  }

  void _onTempoChanged(MetronomeTempoChanged event, Emitter<MetronomeState> emit) {
    _tempo = event.tempo;
    _tickerSubscription?.cancel(); 
    if (state is MetronomePause) {
      add(MetronomePaused());
    } else if (state is MetronomeRun) {
      if (_elapsed - _lastTick < Duration(milliseconds: (60000/_tempo).toInt())) {
        add(_MetronomeTicked(tick: _tick+1));
      }
    }
  }

  void _onTempoIncrement(MetronomeTempoIncrement event, Emitter<MetronomeState> emit) {
    _tempo < 300 ? _tempo++ : null;
    add(MetronomeTempoChanged(tempo: _tempo));
  }

  void _onTempoDecrement(MetronomeTempoDecrement event, Emitter<MetronomeState> emit) {
    _tempo > 0 ? _tempo-- : null;
    add(MetronomeTempoChanged(tempo: _tempo));
  }

  void _onTicked(_MetronomeTicked event, Emitter<MetronomeState> emit) {
    _tick = event.tick % 4 + 1;
    _lastTick = _elapsed;
    emit(MetronomeRun(_tempo, _tick));
  }

}
