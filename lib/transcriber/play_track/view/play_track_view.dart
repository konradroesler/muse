import 'package:flutter/material.dart';

class PlayTrackView extends StatelessWidget {
  const PlayTrackView({super.key});

  @override 
  Widget build(BuildContext context) {
    // TODO implement slider and play/stop button
    return Scaffold(
      body: const Center(
        child: Text(
          'Play Track', style: TextStyle(fontSize: 24)
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }
}
