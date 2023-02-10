import 'package:sandfriends_web/Login/Model/CnpjStore.dart';
import 'package:sandfriends_web/Login/Repository/LoginRepo.dart';

import '../../remote/network/ApiEndPoints.dart';
import '../../remote/network/BaseApiService.dart';
import '../../remote/network/NetworkApiService.dart';

class LoginRepoImp implements LoginRepo {
  BaseApiService _apiService = NetworkApiService();

  @override
  Future<CnpjStore?> getStoreFromCnpj(String cnpj) async {
    try {
      dynamic response =
          await _apiService.getResponse(_apiService.cnpjUrl, cnpj);
      print("MARAJ $response");
      final jsonData = CnpjStore.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
      print("MARAJ-E $e}");
    }
  }
}
