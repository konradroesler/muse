import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';

part 'metronome_event.dart';
part 'metronome_state.dart';

class MetronomeBloc extends Bloc<MetronomeEvent, MetronomeState>{
  MetronomeBloc() : super(MetronomeOff(120, 1)) {
    on<MetronomeTurnedOn>(_onTurnedOn);
    on<MetronomeTurnedOff>(_onTurnedOff);
    on<MetronomeTempoChanged>(_onTempoChanged);
    on<MetronomeTempoIncrement>(_onTempoIncrement);
    on<MetronomeTempoDecrement>(_onTempoDecrement);
    on<_MetronomeTicked>(_onTicked);
  }

  double _tempo = 120;
  int _tick = 1;

  Ticker? _ticker; 
  Duration _lastTick = Duration.zero;
  Duration _lastPureInterval = Duration(milliseconds: 60000~/120);
  
  @override 
  Future<void> close() {
    _ticker?.dispose();
    return super.close();
  }

  Duration _adjustedInterval() {
    return (_lastPureInterval + Duration(milliseconds: 60000~/_tempo))~/2;
  }

  void _checkForTick(Duration elapsed) {
     if (elapsed - _lastTick > _adjustedInterval()) {
      add(_MetronomeTicked(tick: _tick));     
      _lastTick = elapsed;
      _lastPureInterval = Duration(milliseconds: 60000~/_tempo);
     }
  }
  
  void _onTurnedOn(event, emit) {
    _tick = 0;
    _lastTick = Duration(minutes: -1);
    _ticker = Ticker(_checkForTick);
    _ticker?.start();
    emit(MetronomeOn(_tempo, _tick));
  }
  void _onTurnedOff(event, emit) {
    _ticker?.stop();
    emit(MetronomeOff(_tempo, _tick));
  }
  void _onTempoChanged(event, emit) {
    _tempo = event.tempo;
    if (state is MetronomeOff) {
      emit(MetronomeOff(_tempo, _tick));
    } else if (state is MetronomeOn) {
      emit(MetronomeOn(_tempo, _tick));
    }
  }

  void _onTempoIncrement(event, emit) {
    _tempo < 300 ? add(MetronomeTempoChanged(tempo: _tempo+1)) : null; 
  }
  void _onTempoDecrement(event, emit) {
    _tempo > 0 ? add(MetronomeTempoChanged(tempo: _tempo-1)) : null;
  }

  void _onTicked(event, emit) {
    _tick = ((_tick ) % 4) + 1;
    emit(MetronomeOn(_tempo, _tick));
  }
}


