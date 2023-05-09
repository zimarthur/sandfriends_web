import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../SharedComponents/Model/PaymentType.dart';
import '../../../SharedComponents/View/SFPaymentStatus.dart';

class ResumedMatch extends StatelessWidget {
  const ResumedMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: defaultPadding, bottom: 3),
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        boxShadow: const [
          BoxShadow(
            color: divider,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 2,
              vertical: defaultPadding / 4,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Quadra 1",
                    style: TextStyle(
                      color: textWhite,
                    ),
                  ),
                ),
                SFPaymentStatus(paymentType: PaymentType.Paid)
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2,
                vertical: defaultPadding / 2,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: secondaryPaper,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Partida de Arthur",
                    style: TextStyle(
                      color: textBlue,
                    ),
                  ),
                  Text(
                    "Beach tenis",
                    style: TextStyle(
                      color: textDarkGrey,
                    ),
                  ),
                  Text(
                    "09:00 - 10:00",
                    style: TextStyle(
                      color: textDarkGrey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
