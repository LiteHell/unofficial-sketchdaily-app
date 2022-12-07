class Person {
  final String name;
  final String webpage;

  Person(this.name, this.webpage);

  static Person fromJsonObject(dynamic object) {
    return Person(object['name'], object['webpage']);
  }
}
