import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';

import '../../../../../SharedComponents/Model/Court.dart';
import '../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../SharedComponents/View/SFTextfield.dart';
import '../../../../../Utils/Constants.dart';

class BlockHourWidget extends StatefulWidget {
  DateTime day;
  Hour hour;
  Court court;
  TextEditingController controller;
  VoidCallback onReturn;
  VoidCallback onBlock;
  VoidCallback onBlockPermanent;

  BlockHourWidget({
    required this.day,
    required this.hour,
    required this.court,
    required this.controller,
    required this.onReturn,
    required this.onBlock,
    required this.onBlockPermanent,
  });

  @override
  State<BlockHourWidget> createState() => _BlockHourWidgetState();
}

class _BlockHourWidgetState extends State<BlockHourWidget> {
  bool blockedPermanent = false;

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
          Column(
            children: [
              Row(
                children: [
                  Checkbox(
                      activeColor: primaryBlue,
                      value: blockedPermanent,
                      onChanged: (value) {
                        setState(() {
                          blockedPermanent = value!;
                        });
                      }),
                  const Text(
                    "Bloquear horário permanentemente",
                    style: TextStyle(color: textDarkGrey),
                  ),
                ],
              ),
              if (blockedPermanent)
                Text(
                  "*Até que o horário seja desbloqueado, nenhuma partida ou mensalista poderá ser agendada nas ${weekdayRecurrent[getBRWeekday(widget.day.weekday)]} às ${widget.hour.hourString} na ${widget.court.description}",
                  style: TextStyle(color: textDarkGrey),
                  textScaleFactor: 0.85,
                ),
            ],
          ),
          const SizedBox(
            height: 2 * defaultPadding,
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
                  onTap: () {
                    if (blockedPermanent) {
                      widget.onBlockPermanent();
                    } else {
                      widget.onBlock();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
