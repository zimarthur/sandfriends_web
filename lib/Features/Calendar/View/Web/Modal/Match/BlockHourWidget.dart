import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';

import '../../../../../../SharedComponents/Model/Court.dart';
import '../../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../../SharedComponents/Model/Sport.dart';
import '../../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../../SharedComponents/View/SFDropDown.dart';
import '../../../../../../SharedComponents/View/SFTextfield.dart';
import '../../../../../../Utils/Constants.dart';
import '../../../../../../Utils/Validators.dart';

class BlockHourWidget extends StatefulWidget {
  DateTime day;
  Hour hour;
  Court court;
  VoidCallback onReturn;
  Function(String, int) onBlock;
  List<Sport> sports;

  BlockHourWidget({
    required this.day,
    required this.hour,
    required this.court,
    required this.onReturn,
    required this.onBlock,
    required this.sports,
  });

  @override
  State<BlockHourWidget> createState() => _BlockHourWidgetState();
}

class _BlockHourWidgetState extends State<BlockHourWidget> {
  TextEditingController controller = TextEditingController();
  late String selectedSport;
  final formKey = GlobalKey<FormState>();

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
                        emptyCheck(a, "Digite o nome do/da jogador(a)"),
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
                                .firstWhere((sport) =>
                                    sport.description == selectedSport)
                                .idSport,
                          );
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
