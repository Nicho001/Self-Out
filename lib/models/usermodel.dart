class Userws {
  final String name;
  final String location;

  Userws({
    required this.name,
    required this.location,
  });
  factory Userws.fromJson(Map<String, dynamic> parsedJson) {
    return Userws(name: parsedJson['name'], location: parsedJson['location']);
  }
}
