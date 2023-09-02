import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepo.dart';
import 'package:provider/provider.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Court.dart';
import '../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'MyCourtsRepo.dart';

class MyCourtsRepoImp implements MyCourtsRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> addCourt(
    BuildContext context,
    String accessToken,
    Court newCourt,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().addCourt,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "Description": newCourt.description,
          "IsIndoor": newCourt.isIndoor,
          "Sports": [
            for (var sport in newCourt.sports.where((spt) => spt.isAvailable))
              {
                "IdSport": sport.sport.idSport,
              }
          ],
          "OperationDays": [
            for (var operationDay in newCourt.operationDays)
              {
                "Weekday": operationDay.weekday,
                "Prices": [
                  for (var price in operationDay.prices)
                    {
                      "IdHour": price.startingHour.hour,
                      "Price": price.price,
                      "RecurrentPrice": price.recurrentPrice,
                    }
                ]
              }
          ]
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> removeCourt(
      BuildContext context, String accessToken, int idStoreCourt) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().removeCourt,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdStoreCourt": idStoreCourt,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> saveCourtChanges(
    BuildContext context,
    String accessToken,
    List<Court> courts,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().saveCourtChanges,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "Courts": [
            for (var court in courts)
              {
                "IdStoreCourt": court.idStoreCourt,
                "Description": court.description,
                "IsIndoor": court.isIndoor,
                "Sports": [
                  for (var sport
                      in court.sports.where((spt) => spt.isAvailable))
                    {
                      "IdSport": sport.sport.idSport,
                    }
                ],
                "OperationDays": [
                  for (var operationDay in court.operationDays)
                    {
                      "Weekday": operationDay.weekday,
                      "Prices": [
                        for (var price in operationDay.prices)
                          {
                            "IdHour": price.startingHour.hour,
                            "Price": price.price,
                            "RecurrentPrice": price.recurrentPrice,
                          }
                      ]
                    }
                ]
              }
          ]
        },
      ),
    );
    return response;
  }
}
