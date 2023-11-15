import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDropDown.dart';
import 'package:sandfriends_web/Utils/Validators.dart';

import '../../../../../../SharedComponents/Model/Court.dart';
import '../../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../../SharedComponents/Model/Sport.dart';
import '../../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../../SharedComponents/View/SFTextfield.dart';
import '../../../../../../Utils/Constants.dart';

class RecurrentBlockHourWidget extends StatefulWidget {
  DateTime day;
  Hour hour;
  Court court;
  VoidCallback onReturn;
  Function(String, int) onBlock;
  List<Sport> sports;

  RecurrentBlockHourWidget({
    required this.day,
    required this.hour,
    required this.court,
    required this.onReturn,
    required this.onBlock,
    required this.sports,
  });

  @override
  State<RecurrentBlockHourWidget> createState() =>
      _RecurrentBlockHourWidgetState();
}

class _RecurrentBlockHourWidgetState extends State<RecurrentBlockHourWidget> {
  late String selectedSport;
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    selectedSport = widget.sports.first.description;
    super.initState();
  }

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
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Seu mensalista ainda não baixou o app? Fica tranquilo!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: textBlue,
              ),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            const Text(
              "Você pode bloquear o horário para ele/ela enquanto isso, mas fique atento a pontos importantes:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: textDarkGrey,
              ),
            ),
            const SizedBox(
              height: defaultPadding / 4,
            ),
            const Text(
              '- O controle de renovação não será feito pela plataforma Sandfriends\n- O faturamento das partidas agendadas por aqui não será contabilizado na aba "Financeiro"\n- O horário ficará reservado até que você o libere',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: textDarkGrey,
              ),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Text("Nome:")),
                Expanded(
                  flex: 2,
                  child: SFTextField(
                    labelText: "",
                    pourpose: TextFieldPourpose.Standard,
                    controller: controller,
                    validator: (a) =>
                        emptyCheck(a, "Digite o nome do/da mensalista"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Text("Esporte:")),
                Expanded(
                    flex: 2,
                    child: SFDropdown(
                      labelText: selectedSport,
                      items: widget.sports.map((e) => e.description).toList(),
                      validator: (value) {},
                      onChanged: (p0) {
                        setState(() {
                          selectedSport = p0!;
                        });
                      },
                    )),
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
                      if (formKey.currentState?.validate() == true) {
                        widget.onBlock(
                          controller.text,
                          widget.sports
                              .firstWhere(
                                  (sport) => sport.description == selectedSport)
                              .idSport,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
