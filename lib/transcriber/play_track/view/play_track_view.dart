import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/play_track_bloc.dart';

class PlayTrackView extends StatelessWidget {
  const PlayTrackView({super.key});

  @override 
  Widget build(BuildContext context) {
    // TODO implement slider and play/stop button
    return Scaffold(
      body: BlocBuilder<PlayTrackBloc, PlayTrackState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    context.read<PlayTrackBloc>().track.name,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: () {
                    context.read<PlayTrackBloc>().add(const PlayPauseButtonPressed());
                  },
                  child: Icon(
                    state.status.isPlaying ? Icons.pause : Icons.play_arrow
                  ),
                ),
              ],
            ),
          );
        } 
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
