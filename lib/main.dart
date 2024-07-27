import 'package:muse/navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Muse());
}

class Muse extends StatelessWidget {
  const Muse({super.key});

  @override
  Widget build(BuildContext context) {
      return const MaterialApp(
        home: MuseNavigationBar(),
    );
  }
}
