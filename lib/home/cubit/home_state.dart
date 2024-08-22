part of 'home_cubit.dart';

enum HomeTab { metronome, tuner, transcriber }

final class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.metronome,
  });

  final HomeTab tab;

  @override 
  List<Object> get props => [tab];
}
