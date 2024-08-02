import 'package:flutter/material.dart';
import 'package:muse/metronome/metronome.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MetronomePage(),
    );
  }
}
