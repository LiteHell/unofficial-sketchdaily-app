extension ToWhitespaceFirstLetterUpperCaseExtension on String {
  String toWhitespaceFirstLetterUpperCase() {
    if (isEmpty) {
      return this;
    } else {
      final temp = [this[0].toUpperCase()];

      for (var i = 1; i < length; i++) {
        final ch = this[i];
        if (ch == ch.toUpperCase()) {
          temp.add(ch);
        } else {
          temp.last += ch;
        }
      }
      return temp.join(' ');
    }
  }
}
