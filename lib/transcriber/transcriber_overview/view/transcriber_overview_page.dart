import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks_repository/tracks_repository.dart';

import '../bloc/transcriber_overview_bloc.dart';
import 'transcriber_overview_view.dart';

class TranscriberOverviewPage extends StatelessWidget {
  const TranscriberOverviewPage({super.key});

  @override 
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TranscriberOverviewBloc(
        tracksRepository: context.read<TracksRepository>()
      )..add(const TranscriberOverviewSubscriptionRequested()),
      child: const TranscriberOverviewView(),
    );
  }
}
