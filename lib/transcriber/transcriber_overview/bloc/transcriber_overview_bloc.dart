import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tracks_repository/tracks_repository.dart';

part 'transcriber_overview_event.dart';
part 'transcriber_overview_state.dart';

class TranscriberOverviewBloc extends Bloc<TranscriberOverviewEvent, TranscriberOverviewState> {
  TranscriberOverviewBloc({
    required this.tracksRepository,
  }) : super(const TranscriberOverviewState()) {
    on<TranscriberOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TranscriberOverviewTrackDeleted>(_onTrackDeleted);
    on<TranscriberOverviewTrackAdded>(_onTrackAdded);
  }

  final TracksRepository tracksRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: () => TranscriberOverviewStatus.loading));

    await emit.forEach<List<Track>>(
      tracksRepository.getTracks(),
      onData: (tracks) => state.copyWith(
        status: () => TranscriberOverviewStatus.success,
        tracks: () => tracks,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TranscriberOverviewStatus.failure,
      ),
    );
    
  }

  Future<void> _onTrackDeleted(event, emit) async {
    await tracksRepository.deleteTrack(event.track.id);
  }

  Future<void> _onTrackAdded(event, emit) async {
    await tracksRepository.saveTrack(event.track);
  }
}
