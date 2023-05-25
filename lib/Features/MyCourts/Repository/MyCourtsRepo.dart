import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Court.dart';

class MyCourtsRepo {
  Future<NetworkResponse?> addCourt(
    String accessToken,
    Court newCourt,
  ) async {}
  Future<NetworkResponse?> removeCourt(
    String accessToken,
    int idStoreCourt,
  ) async {}
  Future<NetworkResponse?> saveCourtChanges(
    String accessToken,
    List<Court> courts,
  ) async {}
}
