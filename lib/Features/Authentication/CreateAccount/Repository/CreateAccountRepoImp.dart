import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Remote/Url.dart';
import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import '../Model/CreateAccountStore.dart';
import 'CreateAccountRepo.dart';

class CreateAccountRepoImp implements CreateAccountRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> getStoreFromCnpj(
      BuildContext context, String cnpj) async {
    NetworkResponse response = await _apiService.getResponse(
      context,
      cnpjUrl + cnpj,
    );
    return response;
  }

  @override
  Future<NetworkResponse> createAccount(
    BuildContext context,
    CreateAccountStore store,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().createAccount,
      ),
      CreateAccountStoreToJson(store),
    );
    return response;
  }
}
