class Person {
  final String name;
  final String webpage;

  Person(this.name, this.webpage);

  static Person? fromJsonObject(dynamic object) {
    if (object['name'] != null && object['webpage'] != null) {
      return Person(object['name'], object['webpage']);
    } else {
      return null;
    }
  }
}
