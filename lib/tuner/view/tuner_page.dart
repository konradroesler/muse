import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muse/tuner/tuner.dart';

class TunerPage extends StatelessWidget {
  const TunerPage({super.key});

  @override 
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TunerBloc(),
      child: const  TunerView(),
    );
  }
}
