import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muse/metronome/metronome.dart';

class MetronomeView extends StatelessWidget {
  const MetronomeView({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    iconSize: 50,
                    color: Colors.black,
                    onPressed: () {
                        context.read<MetronomeBloc>().add(MetronomeTempoDecrement());
                    }
                  ),
                  SizedBox(width: 100, child: Center(
                      child: BlocSelector<MetronomeBloc, MetronomeState, double>(
                        selector: (state) => state.tempo,
                        builder: (context, state) {
                          return Text("${state.toInt()}", style: TextStyle(fontSize: 40));
                      }
                      ))),
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 50,
                    color: Colors.black,
                    onPressed: () {
                        context.read<MetronomeBloc>().add(MetronomeTempoIncrement());
                    }
                  ),
                ]
              )),
              BlocSelector<MetronomeBloc, MetronomeState, double>(
                selector: (state) => state.tempo,
                builder: (context, state) {
                  return Slider(
                    value: state,
                    max: 300,
                    activeColor: Colors.black,
                    onChanged: (double value) {
                      context.read<MetronomeBloc>().add(MetronomeTempoChanged(tempo: value));
                    } 
                  );
                }
              ),
              Center(
                child: BlocSelector<MetronomeBloc, MetronomeState, int>(
                  selector: (state) => state.tick,
                  builder: (context, state) {
                    final random = Random();
                    return Container(
                      width: 100,
                      decoration: BoxDecoration(color: Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1)),
                      child: Center(child: Text("$state", style: TextStyle(fontSize: 40)))
                    );
                  }
                )
              ),
              Center(
                child: BlocBuilder<MetronomeBloc, MetronomeState>(
                  buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
                  builder: (context, state) {
                    return switch (state) {
                      MetronomeOn() => IconButton(
                        icon: const Icon(Icons.pause),
                        iconSize: 80,
                        color: Colors.black,
                        onPressed: () {
                          context.read<MetronomeBloc>().add(MetronomeTurnedOff());
                        }
                      ),
                      MetronomeOff() => IconButton(
                        icon: const Icon(Icons.play_arrow),
                        iconSize: 80,
                        color: Colors.black,
                        onPressed: () {
                          context.read<MetronomeBloc>().add(MetronomeTurnedOn());
                        }
                      ),
                    };
                  }
                ) 
              )
            ]
          )
        ),
      )
    );
  }
}
