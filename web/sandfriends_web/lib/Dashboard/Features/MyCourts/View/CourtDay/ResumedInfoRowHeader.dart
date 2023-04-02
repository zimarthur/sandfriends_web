import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResumedInfoRowHeader extends StatelessWidget {
  const ResumedInfoRowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
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
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Preço avulso\n',
                style: const TextStyle(
                  color: textLightGrey,
                  fontFamily: 'Lexend',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Preço Mensalista',
                    style: const TextStyle(
                      color: textBlue,
                      fontFamily: 'Lexend',
                      //fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: (2 * defaultPadding) + 20,
          ),
        ],
      ),
    );
  }
}
