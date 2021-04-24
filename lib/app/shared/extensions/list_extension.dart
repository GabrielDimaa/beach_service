extension ListExtendion<T> on List<T> {
  T get firstOrNull => this.isEmpty ? null : this.first;
  T get lastOrNull => this.isEmpty ? null : this.last;
}