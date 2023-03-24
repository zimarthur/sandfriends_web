import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class PriceSelectorHeader extends StatelessWidget {
  const PriceSelectorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "Intervalo",
            style: TextStyle(color: textLightGrey),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "Avulso",
            style: TextStyle(color: textLightGrey),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "Mensalista",
            style: TextStyle(color: textLightGrey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
