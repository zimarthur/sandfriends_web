import 'dart:convert';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';

import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../Model/CreateAccountStore.dart';
import 'CreateAccountRepo.dart';

class CreateAccountRepoImp implements CreateAccountRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> getStoreFromCnpj(String cnpj) async {
    NetworkResponse response = await _apiService.getResponse(
      _apiService.cnpjUrl,
      cnpj,
    );
    return response;
  }

  @override
  Future<NetworkResponse> createAccount(
    CreateAccountStore store,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().createAccount,
      CreateAccountStoreToJson(store),
    );
    return response;
  }
}
