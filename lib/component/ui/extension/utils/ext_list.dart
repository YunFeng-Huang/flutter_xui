extension ExtList<T> on List<T> {
  List<T> copy() => List.from(this, growable: true);

  List<R> mapIndexed<R>(R Function(T, int) onMap) =>
      asMap().entries.map((entry) => onMap(entry.value, entry.key)).toList();
}
