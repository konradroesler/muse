import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "models/counter_model.dart";

class Metronome extends StatefulWidget {
  const Metronome({super.key});

  @override
  State<Metronome> createState() => _MetronomeState();
}

class _MetronomeState extends State<Metronome> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(
      builder: (context, value, child) => SafeArea(
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
                      final counter = context.read<CounterModel>();
                      value.count > 0 ? value.count : null;
                      counter.updateCounter();
                    }
                  ),
                  SizedBox(width: 100, child: Center(child: Text("${value.tempo}", style: TextStyle(fontSize: 40)))),
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 50,
                    color: Colors.black,
                    onPressed: () {
                      final counter = context.read<CounterModel>();
                      value.tempo < 300 ? value.tempo++ : null;
                      counter.updateCounter();
                    }
                  ),
                ]
              ))),
              Slider(
                value: value.tempo.toDouble(),
                max: 300,
                activeColor: Colors.black,
                onChanged: (double value) {
                  final counter = context.read<CounterModel>();
                  counter.tempo = value.toInt(); 
                  counter.updateCounter();
                } 
              ),
              Expanded(flex: 1, child: Center(
                child: Text("${value.count}", style: TextStyle(fontSize: 40))
              )),
              Expanded(flex: 1, child:  Center(
                child: IconButton(
                  icon: value.running ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  iconSize: 80,
                  color: Colors.black,
                  onPressed: () {
                    final counter = context.read<CounterModel>();
                    value.running = !value.running;
                    value.running ? counter.runCounter() : counter.stopCounter();
                  }
                )
              ))
            ]
          )
        ),
     )
    );
  }
}
