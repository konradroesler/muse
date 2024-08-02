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
                        context.read<MetronomeBloc>().add(MetronomeTempoIncrement());
                    }
                  ),
                  SizedBox(width: 100, child: Center(
                      child: BlocSelector<MetronomeBloc, MetronomeState, int>(
                        selector: (state) => state.tick,
                        builder: (context, state) {
                          return Text("$state", style: TextStyle(fontSize: 40));
                      }
                      ))),
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 50,
                    color: Colors.black,
                    onPressed: () {
                        context.read<MetronomeBloc>().add(MetronomeTempoDecrement());
                    }
                  ),
                ]
              ))),
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
              Expanded(flex: 1, child: Center(
                child: BlocSelector<MetronomeBloc, MetronomeState, int>(
                  selector: (state) => state.tick,
                  builder: (context, state) {
                    return Text("$state", style: TextStyle(fontSize: 40));
                  }
                )
              )),
              Expanded(flex: 1, child:  Center(
                child: BlocBuilder<MetronomeBloc, MetronomeState>(
                  buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
                  builder: (context, state) {
                    return switch (state) {
                      MetronomeInitial() => IconButton(
                        icon: const Icon(Icons.play_arrow),
                        iconSize: 80,
                        color: Colors.black,
                        onPressed: () {
                          context.read<MetronomeBloc>().add(MetronomeStarted());
                        }
                      ),
                      MetronomeRun() => IconButton(
                        icon: const Icon(Icons.pause),
                        iconSize: 80,
                        color: Colors.black,
                        onPressed: () {
                          context.read<MetronomeBloc>().add(MetronomePaused());
                        }
                      ),
                      MetronomePause() => IconButton(
                        icon: const Icon(Icons.play_arrow),
                        iconSize: 80,
                        color: Colors.black,
                        onPressed: () {
                          context.read<MetronomeBloc>().add(MetronomeResumed());
                        }
                      ),
                    };
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
