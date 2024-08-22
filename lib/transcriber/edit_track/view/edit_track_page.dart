import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks_repository/tracks_repository.dart';

import '../bloc/edit_track_bloc.dart';
import 'edit_track_view.dart';

class EditTrackPage extends StatelessWidget {
  const EditTrackPage({super.key});

  static Route<void> route({required Track track}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditTrackBloc(
          tracksRepository: context.read<TracksRepository>(),
          track: track,
        ),
        child: const EditTrackPage(),
      )
    );
  }

  @override 
  Widget build(BuildContext context) {
    return BlocListener<EditTrackBloc, EditTrackState>(
      listenWhen: (previous, current) => 
          previous.status != current.status &&
          current.status == EditTrackStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditTrackView(),
    );
  }
}
