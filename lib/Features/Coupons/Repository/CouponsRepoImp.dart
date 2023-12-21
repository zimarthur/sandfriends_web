import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Coupons/Repository/CouponsRepo.dart';
import 'package:sandfriends_web/Features/Players/Repository/PlayersRepo.dart';
import 'package:sandfriends_web/SharedComponents/Model/EnumDiscountType.dart';
import 'package:sandfriends_web/SharedComponents/Model/Player.dart';

import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import 'package:sandfriends_web/Features/Authentication/Login/Repository/LoginRepo.dart';
import 'package:provider/provider.dart';
import '../../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Coupon.dart';
import '../../../SharedComponents/Model/Court.dart';
import '../../../SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'package:intl/intl.dart';

class CouponsRepoImp implements CouponsRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> enableDisableCoupon(
    BuildContext context,
    String accessToken,
    Coupon coupon,
    bool disable,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().enableDisableCoupon,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "IdCoupon": coupon.idCoupon,
          "Disable": disable,
        },
      ),
    );
    return response;
  }

  @override
  Future<NetworkResponse> addCoupon(
    BuildContext context,
    String accessToken,
    Coupon coupon,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      context,
      Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
        ApiEndPoints().addCoupon,
      ),
      jsonEncode(
        <String, Object>{
          "AccessToken": accessToken,
          "Code": coupon.couponCode,
          "Value": coupon.value,
          "DiscountType": coupon.discountType.text,
          "DateBegin": DateFormat("dd/MM/yyyy").format(
            coupon.startingDate,
          ),
          "DateEnd": DateFormat("dd/MM/yyyy").format(
            coupon.endingDate,
          ),
          "IdTimeBegin": coupon.hourBegin.hour,
          "IdTimeEnd": coupon.hourEnd.hour,
        },
      ),
    );
    return response;
  }
}
