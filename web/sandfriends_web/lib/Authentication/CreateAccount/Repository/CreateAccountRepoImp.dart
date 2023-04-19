import 'dart:convert';
import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';
import 'package:sandfriends_web/Authentication/Login/Repository/LoginRepo.dart';
import '../Model/CnpjStore.dart';
import '../Model/CreateAccountStore.dart';
import 'CreateAccountRepo.dart';

class CreateAccountRepoImp implements CreateAccountRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<CnpjStore?> getStoreFromCnpj(String cnpj) async {
    try {
      dynamic response =
          await _apiService.getResponse(_apiService.cnpjUrl, cnpj);
      print("MARAJ $response");
      final jsonData = CnpjStore.fromJson(response);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future createAccount(CreateAccountStore store) async {
    dynamic response = await _apiService
        .postResponse(
          _apiService.sandfriendsUrl,
          ApiEndPoints().createAccount,
          CreateAccountStoreToJson(store),
          false,
        )
        .onError((error, stackTrace) => throw error!);
  }

  @override
  Future createAccountEmployee(String email, String password) async {
    dynamic response = await _apiService
        .postResponse(
          _apiService.sandfriendsUrl,
          ApiEndPoints().login,
          jsonEncode(
            <String, Object>{
              "Email": email,
              "Password": password,
            },
          ),
          true,
        )
        .onError((error, stackTrace) => throw error!);
    return response;
  }
}
