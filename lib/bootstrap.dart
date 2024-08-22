import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:muse/observer.dart';
import 'package:tracks_api/tracks_api.dart';
import 'package:tracks_repository/tracks_repository.dart';

import 'app.dart';

void bootstrap({required TracksApi tracksApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const MuseBlocObserver();

  final tracksRepository = TracksRepository(tracksApi: tracksApi);

  runZonedGuarded(
    () => runApp(App(tracksRepository: tracksRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace), 
  );

}
