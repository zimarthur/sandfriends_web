import '../../../../../Remote/BaseApiService.dart';
import '../../../../../Remote/NetworkApiService.dart';
import 'EmployeeInfoRepo.dart';

class EmployeeInfoRepoImp implements EmployeeInfoRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future RenameEmployee(String firstName, String lastName, String accessToken) {
    // TODO: implement RenameEmployee
    throw UnimplementedError();
  }
}
