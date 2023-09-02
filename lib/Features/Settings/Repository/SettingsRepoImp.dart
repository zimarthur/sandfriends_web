import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../Remote/ApiEndPoints.dart';
import '../../../Remote/BaseApiService.dart';
import '../../../Remote/NetworkApiService.dart';
import '../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Store.dart';
import '../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'SettingsRepo.dart';
import 'package:provider/provider.dart';

class SettingsRepoImp implements SettingsRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> updateStoreInfo(
      BuildContext context, Store store, bool changedLogo) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().updateStoreInfo,
      ),
      jsonEncode(
        <String, Object>{
          "IdStore": store.idStore,
          "Name": store.name,
          "Address": store.address,
          "AddressNumber": store.addressNumber,
          "City": store.city.name,
          "State": store.city.state.uf,
          "PhoneNumber1": store.phoneNumber,
          "PhoneNumber2": store.ownerPhoneNumber ?? "",
          "Description": store.description ?? "",
          "Instagram": store.instagram ?? "",
          "Cnpj": store.cnpj ?? "",
          "Cep": store.cep,
          "Neighbourhood": store.neighbourhood,
          "Logo": changedLogo ? store.logo : "",
          "Photos": [
            for (var photo in store.photos)
              if (photo.isNewPhoto)
                {
                  "IdStorePhoto": "",
                  "Photo": base64Encode(photo.newPhoto),
                }
              else
                {
                  "IdStorePhoto": photo.idStorePhoto,
                  "Photo": photo.photo,
                }
          ]
        },
      ),
    );
    return response;
  }
}
