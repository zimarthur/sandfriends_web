class Sport {
  int idSport;
  String description;
  String sportPhoto;

  Sport({
    required this.idSport,
    required this.description,
    required this.sportPhoto,
  });

  factory Sport.fromJson(Map<String, dynamic> parsedJson) {
    return Sport(
      idSport: parsedJson["IdSport"],
      description: parsedJson["Description"],
      sportPhoto: parsedJson["SportPhoto"],
    );
  }
}
