class TunerTicker {
  const TunerTicker();

  Stream<int> tick(Duration sampleRate) {
    return Stream.periodic(sampleRate, (x) => x);
  }
}
