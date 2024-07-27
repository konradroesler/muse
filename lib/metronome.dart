import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter/services.dart";

class Metronome extends StatefulWidget {
  const Metronome({super.key});

  @override
  State<Metronome> createState() => _MetronomeState();
}

class _MetronomeState extends State<Metronome> with SingleTickerProviderStateMixin {

  Ticker? _ticker;
  double _bpm = 60;
  int _currentTick = 1;
  double _intervalMs = 1000;
  double _lastElapsedTime = 0;
  double _lastPureInterval = 1000;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
    _startTicker();
  }

  void _startTicker() {
    _intervalMs = 60000 / _bpm;
    _ticker?.start();
  }
  
  double _adjustedInterval() {
    return (_lastPureInterval + _intervalMs)/2;
  }

  void _tick(Duration elapsed) {
    double elapsedTime = elapsed.inMilliseconds.toDouble();
    if (elapsedTime - _lastElapsedTime >= _adjustedInterval()) {
      _lastPureInterval = _intervalMs;
      _lastElapsedTime = elapsedTime;
      if (_running) {
        _playTickSound();
        setState(() {
          _currentTick < 4 ? _currentTick++ : _currentTick = 1;
        });
      }
    }
  }

  void _playTickSound() {
    SystemSound.play(SystemSoundType.click);
  }

  void _updateBpm(double bpm) {
    setState(() {
      _bpm = bpm;
      _intervalMs = 60000 / _bpm;
    });
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 1, child: Center(
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    iconSize: 50,
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        _bpm > 0 ? _bpm-- : null;
                      });
                    }
                  ),
                  SizedBox(width: 100, child: Center(child: Text("${_bpm.toInt()}", style: TextStyle(fontSize: 40)))),
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 50,
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        _bpm < 300 ? _bpm++ : null;
                      });
                    }
                  ),
                ]
              ))),
              Slider(
                value: _bpm.toDouble(),
                max: 300,
                activeColor: Colors.black,
                onChanged: (double value) {
                  _updateBpm(value);
                } 
              ),
              Expanded(flex: 1, child: Center(
                child: Text("$_currentTick", style: TextStyle(fontSize: 40))
              )),
              Expanded(flex: 1, child:  Center(
                child: IconButton(
                  icon: _running ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  iconSize: 80,
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      _running = !_running;
                    });
                  }
                )
              ))
            ]
          )
        ),
      );
    }
}
