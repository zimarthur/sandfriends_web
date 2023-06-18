import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';

import '../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../SharedComponents/View/SFTextfield.dart';
import '../../../../../Utils/Constants.dart';

class RecurrentBlockHourWidget extends StatefulWidget {
  DateTime day;
  Hour hour;
  int idStoreCourt;
  VoidCallback onReturn;
  VoidCallback onBlock;
  TextEditingController controller;

  RecurrentBlockHourWidget({
    required this.day,
    required this.hour,
    required this.idStoreCourt,
    required this.onReturn,
    required this.onBlock,
    required this.controller,
  });

  @override
  State<RecurrentBlockHourWidget> createState() =>
      _RecurrentBlockHourWidgetState();
}

class _RecurrentBlockHourWidgetState extends State<RecurrentBlockHourWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Gostaria de deixar um lembrete com o motivo do bloqueio?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: textBlue,
            ),
          ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
          SFTextField(
            labelText: "",
            pourpose: TextFieldPourpose.Multiline,
            minLines: 4,
            maxLines: 4,
            hintText: "Manutenção da quadra, nenhum funcionário nessa hora...",
            controller: widget.controller,
            validator: (a) {
              return null;
            },
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "*Ao bloquear um horário mensalista, nenhuma partida poderá ser agendada até que ele seja desbloqueado.\nAs partidas já agendadas nesse horário serão mantidas.",
              style: TextStyle(
                color: textDarkGrey,
              ),
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              Expanded(
                child: SFButton(
                  buttonLabel: "Voltar",
                  buttonType: ButtonType.Secondary,
                  onTap: widget.onReturn,
                ),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: SFButton(
                  buttonLabel: "Bloquear Horário",
                  buttonType: ButtonType.Delete,
                  onTap: widget.onBlock,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
