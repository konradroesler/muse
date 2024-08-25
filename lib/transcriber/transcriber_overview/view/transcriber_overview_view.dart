import 'dart:io';

import 'package:path/path.dart';
import 'package:utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:muse/transcriber/play_track/play_track.dart';
import 'package:tracks_repository/tracks_repository.dart';

import '../bloc/transcriber_overview_bloc.dart';
import '../widgets/widgets.dart';

class TranscriberOverviewView extends StatelessWidget {
  const TranscriberOverviewView({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TranscriberOverviewBloc, TranscriberOverviewState>(
        builder: (context, state) {
          if (state.tracks.isEmpty) {
            if (state.status == TranscriberOverviewStatus.loading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state.status != TranscriberOverviewStatus.success) {
              return const SizedBox();
            } else {
              return Center(
                child: Text('No tracks'),
              );
            }
          }

          return CupertinoScrollbar(
            child: ListView(
              children: [
                for (final track in state.tracks) 
                  TrackListTile(
                    track: track,
                    onDismissed: (_) {
                      context
                        .read<TranscriberOverviewBloc>()
                        .add(TranscriberOverviewTrackDeleted(track));
                    },
                    onTap: () {
                      Navigator.of(context).push(PlayTrackPage.route(track: track));
                    },
                  )
              ]
            ),
          );
        } 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
          if (result != null) {
            final file = File(result.files.single.path!);
            final name = result.files.single.name;
            final bytes = await file.readAsBytes();
            final track = Track(name: name, file: bytes);

            // new, working
            final dbPath = await utilsGetDatabasePath();
            final fileExtensionString = utilsGetFileExtensionAsString(name);
            final localStorageLocationPath = join(dbPath, '${track.id}.$fileExtensionString');
            await file.copy(localStorageLocationPath);

            if (!context.mounted) return;
            context.read<TranscriberOverviewBloc>().add(TranscriberOverviewTrackAdded(track));
          }
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}
