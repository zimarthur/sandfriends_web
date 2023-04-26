class Hour {
  int hour;
  String hourString;

  Hour({
    required this.hour,
    required this.hourString,
  });

  factory Hour.fromJson(Map<String, dynamic> parsedJson) {
    return Hour(
      hour: parsedJson["IdAvailableHour"],
      hourString: parsedJson["HourString"],
    );
  }
}
