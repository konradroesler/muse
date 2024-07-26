import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";

class Metronome extends StatefulWidget {
  const Metronome({super.key});

  @override
  State<Metronome> createState() => _MetronomeState();
}

class _MetronomeState extends State<Metronome> {

  int _count = 1;
  int _tempo = 120;
  bool _running = false;
  late Timer _timer;

  void _runCounter() {
    int milliseconds = (60000/_tempo).round();
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      setState(() {
        _count < 4 ? _count++ : _count = 1;
        SystemSound.play(SystemSoundType.click);
      });
    });
  }

  void _stopCounter() {
    _timer.cancel();
  }

  void _updateCounter() {
    if (_running) {
      _stopCounter();
      _runCounter();
    }
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
                        _tempo > 0 ? _tempo-- : null;
                        _updateCounter();
                      });
                    }
                  ),
                  SizedBox(width: 100, child: Center(child: Text("$_tempo", style: TextStyle(fontSize: 40)))),
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 50,
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        _tempo < 300 ? _tempo++ : null;
                        _updateCounter();
                      });
                    }
                  ),
                ]
              ))),
              Slider(
                value: _tempo.toDouble(),
                max: 300,
                activeColor: Colors.black,
                onChanged: (double value) {
                  setState(() {
                    _tempo = value.toInt(); 
                    _updateCounter();
                  });
                } 
              ),
              Expanded(flex: 1, child: Center(
                child: Text("$_count", style: TextStyle(fontSize: 40))
              )),
              Expanded(flex: 1, child:  Center(
                child: IconButton(
                  icon: _running ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  iconSize: 80,
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      _running = !_running;
                      _running ? _runCounter() : _stopCounter();
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
