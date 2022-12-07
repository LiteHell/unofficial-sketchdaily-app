extension ToFirstLetterUpperCaseExtension on String {
  String toFirstLetterUpperCase() {
    if (isEmpty) {
      return this;
    } else {
      return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
    }
  }
}
