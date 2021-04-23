extension StringExtension on String {
  bool isNullOrEmpty() => this == null || this.trim().isEmpty;

  bool notIsNullOrEmpty() => !this.isNullOrEmpty();

  String extrairNum() {
    if (this.isNullOrEmpty()) {
      return '';
    }

    final iReg = RegExp(r'(\d+)');
    return iReg.allMatches(this).map((m) => m.group(0)).join('');
  }
}