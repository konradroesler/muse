class MetronomeTicker {
  const MetronomeTicker({required double tempo}) : _tempo = tempo;

  final double _tempo;

  Stream<int> tick({required tempo}) {
    int milliseconds = (60000/_tempo).toInt();
    return Stream.periodic(Duration(milliseconds: milliseconds), (x) => x);
  }
}
