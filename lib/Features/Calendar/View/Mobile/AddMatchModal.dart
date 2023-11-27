import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Features/Calendar/Model/BlockMatch.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import '../../../../SharedComponents/Model/Court.dart';
import '../../../../SharedComponents/Model/Hour.dart';
import '../../../../SharedComponents/Model/Sport.dart';
import '../../../../SharedComponents/View/SFDropDown.dart';
import '../../../../Utils/Constants.dart';
import '../../Model/CalendarType.dart';
import 'package:provider/provider.dart';

class AddMatchModal extends StatefulWidget {
  final VoidCallback onReturn;
  final Function(BlockMatch) onSelected;
  Hour timeBegin;
  Hour timeEnd;
  Court court;
  AddMatchModal({
    required this.onReturn,
    required this.onSelected,
    required this.timeBegin,
    required this.timeEnd,
    required this.court,
    super.key,
  });

  @override
  State<AddMatchModal> createState() => _AddMatchModalState();
}

class _AddMatchModalState extends State<AddMatchModal> {
  CalendarType selectedMatchType = CalendarType.Match;
  bool hasSelectedMatchType = false;

  TextEditingController nameController = TextEditingController();
  List<Sport> sports = [];
  late String selectedSport;

  @override
  void initState() {
    sports = Provider.of<DataProvider>(context, listen: false).availableSports;
    selectedSport = sports.first.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(
        defaultPadding,
      ),
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryDarkBlue, width: 1),
        boxShadow: const [BoxShadow(blurRadius: 1, color: primaryDarkBlue)],
      ),
      width: width * 0.9,
      height: height * 0.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => widget.onReturn(),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: SvgPicture.asset(
                  r"assets/icon/x.svg",
                  color: textDarkGrey,
                  height: 20,
                ),
              ),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                r"assets/icon/calendar_add.svg",
                color: primaryBlue,
              ),
              SizedBox(
                width: defaultPadding / 2,
              ),
              const Text(
                "Nova partida",
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          Text(
            "${widget.court.description}  |  ${widget.timeBegin.hourString} - ${widget.timeEnd.hourString}",
            style: TextStyle(
              color: textDarkGrey,
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              double spacer = defaultPadding;
              double collapsedHeight = (constraints.maxHeight - spacer) / 2;
              double expandedHeight = constraints.maxHeight;
              return Column(
                children: [
                  AddMatchType(
                    title: "Partida avulsa",
                    subTitle:
                        "Reserve o horário somente no dia e horário selecionado.",
                    matchType: CalendarType.Match,
                    selectedMatchType: selectedMatchType,
                    onTap: () => setState(() {
                      selectedMatchType = CalendarType.Match;
                    }),
                    height: hasSelectedMatchType
                        ? selectedMatchType == CalendarType.Match
                            ? expandedHeight
                            : 0
                        : collapsedHeight,
                    isExpanded: hasSelectedMatchType &&
                        selectedMatchType == CalendarType.Match,
                    nameController: nameController,
                    sports: sports,
                    selectedSport: selectedSport,
                  ),
                  if (!hasSelectedMatchType)
                    SizedBox(
                      height: spacer,
                    ),
                  AddMatchType(
                    title: "Partida mensalista",
                    subTitle:
                        "Deixe esse horário reservado recorrentemente todas semanas nesse dia e horário.",
                    matchType: CalendarType.RecurrentMatch,
                    selectedMatchType: selectedMatchType,
                    onTap: () => setState(() {
                      selectedMatchType = CalendarType.RecurrentMatch;
                    }),
                    height: hasSelectedMatchType
                        ? selectedMatchType == CalendarType.RecurrentMatch
                            ? expandedHeight
                            : 0
                        : collapsedHeight,
                    isExpanded: hasSelectedMatchType &&
                        selectedMatchType == CalendarType.RecurrentMatch,
                    nameController: nameController,
                    sports: sports,
                    selectedSport: selectedSport,
                  ),
                ],
              );
            }),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              if (hasSelectedMatchType)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 4),
                    child: SFButton(
                      buttonLabel: "Voltar",
                      buttonType: ButtonType.Secondary,
                      onTap: () => setState(() {
                        hasSelectedMatchType = false;
                      }),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 4),
                  child: SFButton(
                      buttonLabel:
                          hasSelectedMatchType ? "Criar partida" : "Continuar",
                      buttonType: ButtonType.Primary,
                      onTap: () {
                        if (!hasSelectedMatchType) {
                          setState(() {
                            hasSelectedMatchType = true;
                          });
                        } else {
                          widget.onSelected(
                            BlockMatch(
                              isRecurrent: selectedMatchType ==
                                  CalendarType.RecurrentMatch,
                              idStoreCourt: widget.court.idStoreCourt!,
                              timeBegin: widget.timeBegin,
                              name: nameController.text,
                              idSport: sports
                                  .firstWhere((sport) =>
                                      sport.description == selectedSport)
                                  .idSport,
                            ),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddMatchType extends StatefulWidget {
  String title;
  String subTitle;
  CalendarType matchType;
  CalendarType selectedMatchType;
  VoidCallback onTap;
  double height;
  bool isExpanded;
  TextEditingController nameController;
  List<Sport> sports;
  String selectedSport;

  AddMatchType(
      {required this.title,
      required this.subTitle,
      required this.matchType,
      required this.selectedMatchType,
      required this.onTap,
      required this.height,
      required this.isExpanded,
      required this.nameController,
      required this.sports,
      required this.selectedSport,
      super.key});

  @override
  State<AddMatchType> createState() => _AddMatchTypeState();
}

class _AddMatchTypeState extends State<AddMatchType> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 200,
        ),
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            defaultBorderRadius,
          ),
          border: Border.all(
            color: widget.matchType == widget.selectedMatchType
                ? widget.selectedMatchType == CalendarType.Match
                    ? primaryBlue
                    : primaryLightBlue
                : divider,
            width: widget.matchType == widget.selectedMatchType ? 4 : 2,
          ),
          gradient: widget.matchType == widget.selectedMatchType
              ? RadialGradient(
                  colors: [
                    widget.selectedMatchType == CalendarType.Match
                        ? primaryBlue.withOpacity(0.5)
                        : primaryLightBlue.withOpacity(0.5),
                    textWhite,
                  ],
                  center: Alignment.topLeft,
                )
              : null,
        ),
        child: widget.height == 0
            ? Container()
            : Padding(
                padding: EdgeInsets.all(
                  defaultPadding / 2,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: Radio(
                            value: widget.matchType,
                            groupValue: widget.selectedMatchType,
                            activeColor:
                                widget.selectedMatchType == CalendarType.Match
                                    ? primaryBlue
                                    : primaryLightBlue,
                            onChanged: (a) => widget.onTap(),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: widget.selectedMatchType ==
                                            CalendarType.Match
                                        ? primaryBlue
                                        : primaryLightBlue,
                                  ),
                                ),
                              ),
                              Text(
                                widget.subTitle,
                                style: TextStyle(
                                  color: textDarkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (widget.isExpanded)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: defaultPadding,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text("Nome:"),
                                  SizedBox(
                                    width: defaultPadding / 2,
                                  ),
                                  Expanded(
                                    child: SFTextField(
                                        labelText: "",
                                        pourpose: TextFieldPourpose.Standard,
                                        controller: widget.nameController,
                                        validator: (a) {}),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Esporte:"),
                                  SizedBox(
                                    width: defaultPadding / 2,
                                  ),
                                  Expanded(
                                      child: SFDropdown(
                                    align: Alignment.centerRight,
                                    labelText: widget.selectedSport,
                                    items: widget.sports
                                        .map((e) => e.description)
                                        .toList(),
                                    validator: (value) {},
                                    onChanged: (p0) {
                                      setState(() {
                                        widget.selectedSport = p0!;
                                      });
                                    },
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
