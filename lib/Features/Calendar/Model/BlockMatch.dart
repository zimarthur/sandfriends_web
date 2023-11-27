import '../../../SharedComponents/Model/Hour.dart';

class BlockMatch {
  bool isRecurrent;
  int idStoreCourt;
  Hour timeBegin;
  String name;
  int idSport;

  BlockMatch({
    required this.isRecurrent,
    required this.idStoreCourt,
    required this.timeBegin,
    required this.name,
    required this.idSport,
  });
}
