import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muse/home/home.dart';
import 'package:muse/theme/theme.dart';
import 'package:tracks_repository/tracks_repository.dart';

class App extends StatelessWidget {
  const App({required this.tracksRepository, super.key});

  final TracksRepository tracksRepository;

  @override 
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: tracksRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MuseTheme.light,
      darkTheme: MuseTheme.dark,
      home: const HomePage(),
    );
  }
}
