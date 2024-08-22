import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muse/tuner/tuner.dart';

class TunerView extends StatelessWidget {
  const TunerView({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<TunerBloc, TunerState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text('Note: ${state.note}', style: TextStyle(fontSize: 40)),
                  Text('Pitch: ${state.pitch}', style: TextStyle(fontSize: 40)),
                ]
              );
            }
          ),
          const SizedBox(height: 20),
          BlocBuilder<TunerBloc, TunerState>(
            builder: (context, state) {
              return switch (state) {
                TunerRecording() => FloatingActionButton.large(
                  onPressed: () {
                    context.read<TunerBloc>().add(const TunerRecordingEnded());
                  },
                child: const Icon(Icons.pause, size: 50),
                ),
                _ => FloatingActionButton.large(
                  onPressed: () {
                    context.read<TunerBloc>().add(const TunerRecordingStarted());
                  },
                  child: const Icon(Icons.play_arrow, size: 50),
                ),
              };
            } 
          ) 
        ]
      ))
    );
  }
}
