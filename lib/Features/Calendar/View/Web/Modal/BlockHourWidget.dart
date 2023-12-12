import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDropDown.dart';
import 'package:sandfriends_web/SharedComponents/View/SelectPlayer.dart';
import 'package:sandfriends_web/Utils/Validators.dart';
import 'package:provider/provider.dart';
import '../../../../../../SharedComponents/Model/Court.dart';
import '../../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../../SharedComponents/Model/Player.dart';
import '../../../../../../SharedComponents/Model/Sport.dart';
import '../../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../../SharedComponents/View/SFTextfield.dart';
import '../../../../../../Utils/Constants.dart';
import '../../../../../../Utils/SFDateTime.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BlockHourWidget extends StatefulWidget {
  bool isRecurrent;
  DateTime day;
  Hour hour;
  Court court;
  VoidCallback onReturn;
  Function(Player, int, String) onBlock;
  List<Sport> sports;
  VoidCallback onAddNewPlayer;

  BlockHourWidget({
    required this.isRecurrent,
    required this.day,
    required this.hour,
    required this.court,
    required this.onReturn,
    required this.onBlock,
    required this.sports,
    required this.onAddNewPlayer,
  });

  @override
  State<BlockHourWidget> createState() => _BlockHourWidgetState();
}

class _BlockHourWidgetState extends State<BlockHourWidget> {
  late String selectedSport;
  final formKey = GlobalKey<FormState>();
  TextEditingController obsController = TextEditingController();
  TextEditingController playerController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool onPlayerSelection = false;
  Player? selectedPlayer;
  String filteredText = "";
  List<Player> players = [];
  List<Player> get filteredPlayers => players
      .where(
        (player) => player.fullName.toLowerCase().contains(
              playerController.text.toLowerCase(),
            ),
      )
      .toList();
  @override
  void initState() {
    selectedSport = widget.sports.first.description;
    players = Provider.of<DataProvider>(context, listen: false).storePlayers;
    playerController.addListener(() {
      setState(() {
        filteredText = playerController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    playerController.removeListener(() {});
    super.dispose();
  }

  void onPlayerSelected(Player player) {
    setState(() {
      onPlayerSelection = false;
      selectedPlayer = player;
      selectedSport = player.sport!.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.4,
      height: height * 0.8,
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(defaultPadding),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isRecurrent
                  ? "Bloqueio de horário mensalista"
                  : "Bloqueio de horário avulso",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: textBlue,
              ),
            ),
            Text(
              "Este horário ficará indisponível para os jogadores. Você pode desbloquear o horário a qualquer momento",
              style: TextStyle(
                fontSize: 14,
                color: textDarkGrey,
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(r"assets/icon/court.svg"),
                      SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text(
                        widget.court.description,
                        style: TextStyle(
                          color: textDarkGrey,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(r"assets/icon/calendar.svg"),
                      SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text(
                        widget.isRecurrent
                            ? weekdayFull[getSFWeekday(widget.day.weekday)]
                            : DateFormat('dd/MM/yyyy').format(
                                widget.day,
                              ),
                        style: TextStyle(
                          color: textDarkGrey,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(r"assets/icon/clock.svg"),
                      SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text(
                        widget.hour.hourString,
                        style: TextStyle(
                          color: textDarkGrey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("Jogador:")),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: onPlayerSelection
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: SFTextField(
                                        labelText: "Pesquisar jogador",
                                        pourpose: TextFieldPourpose.Standard,
                                        controller: playerController,
                                        validator: (a) {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: defaultPadding / 2,
                                    ),
                                    InkWell(
                                        onTap: () => setState(() {
                                              onPlayerSelection = false;
                                            }),
                                        child: SvgPicture.asset(
                                          r"assets/icon/x.svg",
                                          color: textDarkGrey,
                                        )),
                                  ],
                                )
                              : SelectPlayer(
                                  player: selectedPlayer,
                                  onTap: () => setState(
                                    () {
                                      onPlayerSelection = true;
                                    },
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  if (onPlayerSelection)
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(defaultPadding / 2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: textLightGrey,
                                ),
                                color: secondaryBack,
                                borderRadius: BorderRadius.circular(
                                  defaultBorderRadius,
                                ),
                              ),
                              child: players.isEmpty
                                  ? Center(
                                      child: Text(
                                        "Nenhum jogador encontrado",
                                        style: TextStyle(
                                          color: textDarkGrey,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: filteredPlayers.length,
                                      itemBuilder: (context, index) {
                                        bool isPlayerSelected =
                                            filteredPlayers[index] ==
                                                selectedPlayer;
                                        return InkWell(
                                          onTap: () => onPlayerSelected(
                                              filteredPlayers[index]),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: defaultPadding / 4,
                                              horizontal: defaultPadding / 2,
                                            ),
                                            margin: EdgeInsets.only(
                                              bottom: defaultPadding / 4,
                                              top: defaultPadding / 4,
                                              right: 10, //scrollbar
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: isPlayerSelected
                                                      ? primaryBlue
                                                      : divider,
                                                  width:
                                                      isPlayerSelected ? 2 : 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  defaultBorderRadius,
                                                ),
                                                color: secondaryPaper),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  activeColor: primaryBlue,
                                                  value: filteredPlayers[index],
                                                  groupValue: selectedPlayer,
                                                  onChanged: (player) =>
                                                      onPlayerSelected(
                                                          filteredPlayers[
                                                              index]),
                                                ),
                                                SizedBox(
                                                  width: defaultPadding,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    filteredPlayers[index]
                                                        .fullName,
                                                    style: TextStyle(
                                                      color: isPlayerSelected
                                                          ? textBlue
                                                          : textDarkGrey,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  filteredPlayers[index]
                                                      .sport!
                                                      .description,
                                                  style: TextStyle(
                                                    color: isPlayerSelected
                                                        ? textBlue
                                                        : textDarkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                            ),
                          ),
                          SizedBox(
                            height: defaultPadding / 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Não encontrou o jogador? ",
                                style: TextStyle(
                                  color: textDarkGrey,
                                  fontSize: 12,
                                ),
                              ),
                              InkWell(
                                  onTap: () => widget.onAddNewPlayer(),
                                  child: Text(
                                    "Cadastre aqui! ",
                                    style: TextStyle(
                                      color: textBlue,
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text("Esporte:")),
                              SFDropdown(
                                labelText: selectedSport,
                                items: widget.sports
                                    .map((e) => e.description)
                                    .toList(),
                                validator: (value) {},
                                onChanged: (p0) {
                                  setState(() {
                                    selectedSport = p0!;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gostaria de deixar alguma observação?",
                                style: TextStyle(
                                  color: textDarkGrey,
                                ),
                              ),
                              SFTextField(
                                labelText: "",
                                pourpose: TextFieldPourpose.Multiline,
                                minLines: 3,
                                maxLines: 3,
                                controller: obsController,
                                validator: (a) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
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
                    buttonType: selectedPlayer == null
                        ? ButtonType.Disabled
                        : ButtonType.Delete,
                    onTap: () {
                      if (selectedPlayer != null) {
                        widget.onBlock(
                          selectedPlayer!,
                          widget.sports
                              .firstWhere(
                                  (sport) => sport.description == selectedSport)
                              .idSport,
                          obsController.text,
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
