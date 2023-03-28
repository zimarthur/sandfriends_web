import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResumedInfoRowHeader extends StatelessWidget {
  const ResumedInfoRowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Dia",
            style: TextStyle(color: textLightGrey),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "Horário",
            style: TextStyle(color: textLightGrey),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "Aceita\nMensalista?",
            style: TextStyle(color: textLightGrey),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "Preço\n(Mensalista)",
            style: TextStyle(color: textLightGrey),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: defaultPadding + 20,
        )
      ],
    );
  }
}
