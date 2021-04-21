extension StringExtension on String {
  bool isNullOrEmpty() => this == null || this.trim().isEmpty;

  bool notIsNullOrEmpty() => !this.isNullOrEmpty();
}