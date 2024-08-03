import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muse/metronome/metronome.dart';

class MetronomePage extends StatelessWidget {
  const MetronomePage({super.key});

  @override 
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MetronomeBloc(),
      child: const MetronomeView(),
    );
  }
}
