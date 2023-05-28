import 'dart:convert';

import 'package:sandfriends_web/Features/Calendar/Repository/CalendarRepo.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:intl/intl.dart';
import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';

class CalendarRepoImp implements CalendarRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> updateMatchesList(
      String accessToken, DateTime newSelectedDate) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().updateMatchesList,
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "NewSelectedDate": DateFormat("dd/MM/yyyy").format(newSelectedDate),
        },
      ),
    );
    return response;
  }
}
