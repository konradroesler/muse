import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";

class CounterModel extends ChangeNotifier {
  int count = 1;

  int tempo = 120;

  bool running = false;

  late Timer _timer;

  void runCounter() {
    int milliseconds = (60000/tempo).round();
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      count < 4 ? count++ : count = 1;
      notifyListeners();
      SystemSound.play(SystemSoundType.click);
    });
    notifyListeners();
  }

  void stopCounter() {
    _timer.cancel();
    notifyListeners();
  }

  void updateCounter() {
    if (running) {
      stopCounter();
      runCounter();
    } else {
      notifyListeners();
    }
  }
}
