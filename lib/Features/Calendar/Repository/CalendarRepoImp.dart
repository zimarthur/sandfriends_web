import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/Repository/CalendarRepo.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
import 'package:intl/intl.dart';
import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';
import '../../../SharedComponents/ViewModel/EnvironmentProvider.dart';

class CalendarRepoImp implements CalendarRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> updateMatchesList(BuildContext context,
      String accessToken, DateTime newSelectedDate) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().updateMatchesList,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "NewSelectedDate": DateFormat("dd/MM/yyyy").format(newSelectedDate),
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> cancelMatch(
    BuildContext context,
    String accessToken,
    int idMatch,
    String? cancelationReason,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().cancelMatch,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdMatch": idMatch,
          "CancelationReason": cancelationReason ?? "",
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> cancelRecurrentMatch(
    BuildContext context,
    String accessToken,
    int idRecurrentMatch,
    String? cancelationReason,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().cancelRecurrentMatch,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdRecurrentMatch": idRecurrentMatch,
          "CancelationReason": cancelationReason ?? "",
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> blockHour(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    DateTime date,
    int hour,
    int idPlayer,
    int idSport,
    String obs,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().blockHour,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStoreCourt": idStoreCourt,
          "Date": DateFormat("dd/MM/yyyy").format(date),
          "IdHour": hour,
          "IdStorePlayer": idPlayer,
          "IdSport": idSport,
          "BlockedReason": obs,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> unblockHour(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    DateTime date,
    int hour,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().unblockHour,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStoreCourt": idStoreCourt,
          "Date": DateFormat("dd/MM/yyyy").format(date),
          "IdHour": hour,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> recurrentBlockHour(
    BuildContext context,
    String accessToken,
    int idStoreCourt,
    int weekday,
    int hour,
    int idPlayer,
    int idSport,
    String obs,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().recurrentBlockHour,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStoreCourt": idStoreCourt,
          "Weekday": weekday,
          "IdHour": hour,
          "IdStorePlayer": idPlayer,
          "IdSport": idSport,
          "BlockedReason": obs,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> recurrentUnblockHour(
    BuildContext context,
    String accessToken,
    int idRecurrentMatch,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().recurrentUnblockHour,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdRecurrentMatch": idRecurrentMatch,
        },
      ),
    );
    return response;
  }
}
