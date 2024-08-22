part of 'transcriber_overview_bloc.dart';

sealed class TranscriberOverviewEvent extends Equatable {
  const TranscriberOverviewEvent();

  @override
  List<Object> get props => [];
}

final class TranscriberOverviewSubscriptionRequested extends TranscriberOverviewEvent {
  const TranscriberOverviewSubscriptionRequested();
}

final class TranscriberOverviewTrackDeleted extends TranscriberOverviewEvent {
  const TranscriberOverviewTrackDeleted(this.track);

  final Track track;

  @override 
  List<Object> get props => [track];
}

final class TranscriberOverviewTrackAdded extends TranscriberOverviewEvent {
  const TranscriberOverviewTrackAdded(this.track);

  final Track track;

  @override 
  List<Object> get props => [track];
}
