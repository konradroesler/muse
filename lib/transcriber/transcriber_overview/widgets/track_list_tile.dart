import 'package:flutter/material.dart';
import 'package:muse/transcriber/edit_track/view/edit_track_page.dart';
import 'package:tracks_repository/tracks_repository.dart';

class TrackListTile extends StatelessWidget {
  const TrackListTile({
    required this.track,
    super.key,
    this.onDismissed,
    this.onTap,
  });

  final Track track;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override 
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key('trackListTile_dismissible_${track.id}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          track.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          "id: ${track.id}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton(
          itemBuilder: (_) => [
            PopupMenuItem(
              child: TextButton(
                child: Text('Edit'),
                onPressed: () {
                  Navigator.of(context).push(EditTrackPage.route(track: track));
                }
              )
              
            )
          ],
        )
      ),
    );
  }
}
