import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/Coupon.dart';

import '../../../../Remote/NetworkResponse.dart';

class CouponsRepo {
  Future<NetworkResponse?> enableDisableCoupon(
    BuildContext context,
    String accessToken,
    Coupon coupon,
    bool disable,
  ) async {}

  Future<NetworkResponse?> addCoupon(
    BuildContext context,
    String accessToken,
    Coupon coupon,
  ) async {}
}
