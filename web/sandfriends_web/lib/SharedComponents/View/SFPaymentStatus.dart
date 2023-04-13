import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/PaymentType.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class SFPaymentStatus extends StatelessWidget {
  PaymentType paymentType;
  SFPaymentStatus({required this.paymentType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding / 2,
        vertical: defaultPadding / 4,
      ),
      decoration: BoxDecoration(
          color: paymentType == PaymentType.Paid
              ? paidBackground
              : needsPaymentBackground,
          borderRadius: BorderRadius.circular(
            defaultBorderRadius,
          )),
      child: Text(
        paymentType == PaymentType.Paid ? "Pago" : "Pag. no local",
        style: TextStyle(
            color:
                paymentType == PaymentType.Paid ? paidText : needsPaymentText,
            fontSize: 12),
      ),
    );
  }
}
