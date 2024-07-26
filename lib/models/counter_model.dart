import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";

class CounterModel extends ChangeNotifier {
  int _count = 1;
  int get count => _count;
  int _tempo = 120;
  int get tempo => _tempo;
  bool _running = false;
  bool get running => _running;
  late Timer _timer;

  void _runCounter() {
    int milliseconds = (60000/_tempo).round();
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
        _count < 4 ? _count++ : _count = 1;
        SystemSound.play(SystemSoundType.click);
    });
  }

  void _stopCounter() {
    _timer.cancel();
  }

  void updateCounter() {
    if (_running) {
      _stopCounter();
      _runCounter();
    }
  }
}
