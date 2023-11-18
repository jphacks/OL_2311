extension ExtList<T> on List<T> {
  T? lastWhereOrNull(bool Function(T) test) {
    try {
      return lastWhere(test);
    } on StateError catch (_) {
      return null;
    }
  }
}
