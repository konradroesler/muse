part of 'transcriber_overview_bloc.dart';

enum TranscriberOverviewStatus { initial, loading, success, failure }

final class TranscriberOverviewState extends Equatable {
  const TranscriberOverviewState({
    this.status = TranscriberOverviewStatus.initial,
    this.tracks = const [],
  });

  final TranscriberOverviewStatus status;
  final List<Track> tracks;

  TranscriberOverviewState copyWith({
    TranscriberOverviewStatus Function()? status,
    List<Track> Function()? tracks,
  }) {
    return TranscriberOverviewState(
      status: status != null ? status() : this.status,
      tracks: tracks != null ? tracks() : this.tracks,
    );
  }

  @override 
  List<Object> get props => [status, tracks];
}
