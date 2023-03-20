import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/CourtDay/PriceRuleRadio.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/CourtDay/ResumedInfoRow.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/CourtDay/PriceSelector.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';

import '../../ViewModel/MyCourtsViewModel.dart';

class CourtDay extends StatefulWidget {
  double width;
  double height;
  int dayIndex;
  int rules;
  MyCourtsViewModel viewModel;

  CourtDay({
    required this.width,
    required this.height,
    required this.dayIndex,
    this.rules = 2,
    required this.viewModel,
  });

  @override
  State<CourtDay> createState() => _CourtDayState();
}

class _CourtDayState extends State<CourtDay> {
  bool isExpanded = false;
  double borderSize = 2;
  double editIconWidth = 50;
  bool isPriceStandard = true;
  TextEditingController controller = TextEditingController();
  double arrowHeight = 16;

  @override
  Widget build(BuildContext context) {
    double mainRowHeight = widget.height - 2 * borderSize;
    double secondaryRowHeight = mainRowHeight / 2;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isExpanded
          ? isPriceStandard
              ? mainRowHeight * 2 +
                  widget.rules * secondaryRowHeight +
                  defaultPadding / 2 +
                  borderSize +
                  arrowHeight
              : 4 * widget.height
          : widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: primaryBlue),
      padding: EdgeInsets.all(borderSize),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: isExpanded
                        ? isPriceStandard
                            ? mainRowHeight * 2 +
                                widget.rules * secondaryRowHeight +
                                defaultPadding / 2
                            : 4 * mainRowHeight
                        : mainRowHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      color: secondaryPaper,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              right: isExpanded ? editIconWidth : 0),
                          height: mainRowHeight,
                          child: ResumedInfoRow(
                            day: weekday[widget.dayIndex],
                            workingHours:
                                "${widget.viewModel.operationDays[widget.dayIndex].startingHour.hourString} - ${widget.viewModel.operationDays[widget.dayIndex].endingHour.hourString}",
                            allowRecurrentMatch: true,
                            priceRange: "R\$100 - R\$110\n(R\$90 - R\$100",
                            isEditing: isExpanded,
                            rowHeight: mainRowHeight,
                          ),
                        ),
                        isExpanded
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding),
                                  child: Column(
                                    children: [
                                      SFDivider(),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: mainRowHeight * 0.7,
                                        child: Text(
                                          "Regra de preço",
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: secondaryRowHeight,
                                                  child: Row(
                                                    children: [
                                                      Radio(
                                                        value: true,
                                                        groupValue:
                                                            isPriceStandard,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isPriceStandard =
                                                                value!;
                                                          });
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: defaultPadding,
                                                      ),
                                                      Text(
                                                        "Preço único",
                                                        style: TextStyle(
                                                          color: textDarkGrey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: secondaryRowHeight,
                                                  child: Row(
                                                    children: [
                                                      Radio(
                                                        value: false,
                                                        groupValue:
                                                            isPriceStandard,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isPriceStandard =
                                                                value!;
                                                          });
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: defaultPadding,
                                                      ),
                                                      Text(
                                                        "Personalizado",
                                                        style: TextStyle(
                                                          color: textDarkGrey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: secondaryRowHeight,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            "Intervalo",
                                                            style: TextStyle(
                                                                color:
                                                                    textLightGrey),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "Avulso",
                                                            style: TextStyle(
                                                                color:
                                                                    textLightGrey),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "Mensalista",
                                                            style: TextStyle(
                                                                color:
                                                                    textLightGrey),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  isPriceStandard
                                                      ? Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                            vertical:
                                                                defaultPadding /
                                                                    4,
                                                          ),
                                                          height:
                                                              secondaryRowHeight,
                                                          child: PriceSelector(
                                                            startingHour: Hour(
                                                                hour: 1,
                                                                hourString:
                                                                    "08:00"),
                                                            endingHour: Hour(
                                                                hour: 2,
                                                                hourString:
                                                                    "22:00"),
                                                            height:
                                                                secondaryRowHeight,
                                                            availableHours: [
                                                              Hour(
                                                                  hour: 1,
                                                                  hourString:
                                                                      "08:00"),
                                                              Hour(
                                                                  hour: 2,
                                                                  hourString:
                                                                      "22:00"),
                                                            ],
                                                            editHour: false,
                                                            singlePrice:
                                                                controller,
                                                            recurrentPrice:
                                                                controller,
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                widget.rules,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      defaultPadding /
                                                                          4,
                                                                ),
                                                                height:
                                                                    secondaryRowHeight,
                                                                child:
                                                                    PriceSelector(
                                                                  singlePrice:
                                                                      controller,
                                                                  recurrentPrice:
                                                                      controller,
                                                                  height:
                                                                      secondaryRowHeight,
                                                                  startingHour: Hour(
                                                                      hour: 1,
                                                                      hourString:
                                                                          "08:00"),
                                                                  endingHour: Hour(
                                                                      hour: 22,
                                                                      hourString:
                                                                          "22:00"),
                                                                  availableHours: Provider.of<
                                                                              DataProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .availableHours,
                                                                  editHour:
                                                                      true,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                isExpanded
                    ? Container()
                    : InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: SizedBox(
                          width: editIconWidth,
                          child: SvgPicture.asset(
                            r'assets/icon/edit.svg',
                            color: Colors.white,
                            height: 16,
                          ),
                        ),
                      )
              ],
            ),
          ),
          isExpanded
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: SvgPicture.asset(
                      r'assets/icon/chevron_up.svg',
                      color: Colors.white,
                      height: arrowHeight,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
