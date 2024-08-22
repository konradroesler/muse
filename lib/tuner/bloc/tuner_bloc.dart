import 'dart:async';
import 'dart:typed_data';

import 'package:buffered_list_stream/buffered_list_stream.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:record/record.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';

part 'tuner_event.dart';
part 'tuner_state.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState> {
  TunerBloc() : super(const TunerInitial("A", 0)) {
    on<TunerRecordingStarted>(_onRecordingStarted);
    on<TunerRecordingEnded>(_onRecordingEnded);
    on<_TunerPitchChanged>(_onPitchChanged);
  }

  String _note = "A";
  int _pitch = 0;

  final AudioRecorder _audioRecorder = AudioRecorder();
  final PitchDetector _pitchDetector = PitchDetector();
  final PitchHandler _pitchHandler = PitchHandler(InstrumentType.guitar);

  @override
  Future<void> close() {
    _audioRecorder.cancel();
    _audioRecorder.dispose();
    return super.close();
  }

  void _onRecordingStarted(event, emit) async {
    emit(TunerRecording(_note, _pitch));

    final recordStream = await _audioRecorder.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        numChannels: 1,
        bitRate: 128000,
        sampleRate: PitchDetector.DEFAULT_SAMPLE_RATE,
      )
    );

    var audioSampleBufferedStream = bufferedListStream(
      recordStream.map((event) {
        return event.toList();
      }),
      //The library converts a PCM16 to 8bits internally. So we need twice as many bytes
      PitchDetector.DEFAULT_BUFFER_SIZE * 2,
      ) ;

    await for (var audioSample in audioSampleBufferedStream) {
      final intBuffer = Uint8List.fromList(audioSample);

      final detectedPitch = await _pitchDetector.getPitchFromIntBuffer(intBuffer);
      if (detectedPitch.pitched) {
        final pitchResult = await _pitchHandler.handlePitch(detectedPitch.pitch);
        String note = pitchResult.note;
        int pitch = pitchResult.diffCents.toInt();
        if (note != '' && pitch != 0) {
          _note = note;
          _pitch = pitch;
          add(_TunerPitchChanged(_note, _pitch));
        }
      }
    }    
  }

  void _onRecordingEnded(event, emit) async {
    _audioRecorder.cancel();
    emit(TunerIdle(_note, _pitch));
  }

  void _onPitchChanged(event, emit) {
    emit(TunerRecording(event.note, event.pitch));
  }
}
