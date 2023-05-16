import 'dart:convert';

import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';
import '../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Store.dart';
import 'SettingsRepo.dart';

class SettingsRepoImp implements SettingsRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> updateStoreInfo(Store store) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().updateStoreInfo,
      jsonEncode(
        <String, Object>{},
      ),
    );
    return response;
  }
}
