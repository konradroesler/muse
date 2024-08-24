import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks_repository/tracks_repository.dart';

import '../bloc/play_track_bloc.dart';
import 'play_track_view.dart';

class PlayTrackPage extends StatelessWidget {
  const PlayTrackPage({super.key});

  static Route<void> route({required Track track}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => PlayTrackBloc(
          tracksRepository: context.read<TracksRepository>(),
          track: track,
        ),
        child: PlayTrackPage(),
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return const PlayTrackView();
  }
}
