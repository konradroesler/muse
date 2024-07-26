import 'package:muse/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/counter_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => CounterModel(),
    child: const Muse(),
  ));
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
