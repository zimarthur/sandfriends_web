import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Players/Repository/PlayersRepo.dart';
import 'package:sandfriends_web/SharedComponents/Model/Player.dart';

import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepo.dart';
import 'package:provider/provider.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Court.dart';
import '../../../SharedComponents/ViewModel/EnvironmentProvider.dart';

class PlayersRepoImp implements PlayersRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> addPlayer(
      BuildContext context, String accessToken, Player player) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().addStorePlayer,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "FirstName": player.firstName,
          "LastName": player.lastName,
          "PhoneNumber": player.phoneNumber ?? "",
          "IdGenderCategory": player.gender!.idGender,
          "IdSport": player.sport!.idSport,
          "IdRankCategory": player.rank!.idRankCategory,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> editPlayer(
      BuildContext context, String accessToken, Player player) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().editStorePlayer,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStorePlayer": player.id!,
          "FirstName": player.firstName,
          "LastName": player.lastName,
          "PhoneNumber": player.phoneNumber ?? "",
          "IdGenderCategory": player.gender!.idGender,
          "IdSport": player.sport!.idSport,
          "IdRankCategory": player.rank!.idRankCategory,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> deleteStorePlayer(
      BuildContext context, String accessToken, int idStorePlayer) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().deleteStorePlayer,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStorePlayer": idStorePlayer,
        },
      ),
    );
    return response;
  }
}
