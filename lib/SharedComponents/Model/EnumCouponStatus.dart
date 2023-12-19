import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

enum EnumCouponStatus { Valid, Expired, Invalid, Unavailable }

extension EnumCouponStatusString on EnumCouponStatus {
  String get text {
    switch (this) {
      case EnumCouponStatus.Valid:
        return 'Válido';
      case EnumCouponStatus.Expired:
        return 'Expirado';
      case EnumCouponStatus.Invalid:
        return 'Desabilitado';
      case EnumCouponStatus.Unavailable:
        return 'Indisponível';
    }
  }
}

extension EnumCouponStatusColorText on EnumCouponStatus {
  Color get textColor {
    switch (this) {
      case EnumCouponStatus.Valid:
        return greenText;
      case EnumCouponStatus.Expired:
        return redText;
      case EnumCouponStatus.Invalid:
        return textWhite;
      case EnumCouponStatus.Unavailable:
        return blueText;
    }
  }
}

extension EnumCouponStatusColorBg on EnumCouponStatus {
  Color get textBg {
    switch (this) {
      case EnumCouponStatus.Valid:
        return greenBg;
      case EnumCouponStatus.Expired:
        return redBg;
      case EnumCouponStatus.Invalid:
        return textBlack;
      case EnumCouponStatus.Unavailable:
        return blueBg;
    }
  }
}
