part of 'edit_track_bloc.dart';

enum EditTrackStatus { initial, loading, success, failure }

extension EditTrackStatusX on EditTrackStatus {
  bool get isLoadingOrSuccess => [
    EditTrackStatus.loading,
    EditTrackStatus.success,
  ].contains(this);
}

final class EditTrackState extends Equatable {
  const EditTrackState({
    this.status = EditTrackStatus.initial,
    required this.track,
    this.name = '',
  });

  final EditTrackStatus status;
  final Track track;
  final String name;

  EditTrackState copyWith({
    EditTrackStatus? status,
    Track? track,
    String? name,
  }) {
    return EditTrackState(
      status: status ?? this.status,
      track: track ?? this.track,
      name: name ?? this.name,
    );
  }

  @override 
  List<Object?> get props => [status, track, name];
}
