import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class PriceSelectorHeader extends StatelessWidget {
  bool allowRecurrent;

  PriceSelectorHeader({
    required this.allowRecurrent,
  });

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
          child: allowRecurrent
              ? Text(
                  "Mensalista",
                  style: TextStyle(color: textLightGrey),
                  textAlign: TextAlign.center,
                )
              : Container(),
        ),
      ],
    );
  }
}
