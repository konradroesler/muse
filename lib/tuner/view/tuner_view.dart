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
         return switch (state) {
          TunerRecording() => TextButton(
            onPressed: () {
              context.read<TunerBloc>().add(const TunerRecordingEnded());
            },
                child: const Text('Recording...', style: TextStyle(fontSize: 30))
          ),
          _ => TextButton(
            onPressed: () {
              context.read<TunerBloc>().add(const TunerRecordingStarted());
            },
                child: const Text('Start Recording', style: TextStyle(fontSize: 30)),
          ),
         };
      }
      ) ]    )));
  }
}
