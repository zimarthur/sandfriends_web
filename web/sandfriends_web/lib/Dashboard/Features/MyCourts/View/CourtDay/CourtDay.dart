import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/CourtDay/PriceRuleRadio.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/CourtDay/ResumedInfoRow.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/CourtDay/PriceSelector.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';
import 'package:sandfriends_web/SharedComponents/Model/PriceRule.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';

import '../../../../../SharedComponents/Model/Court.dart';
import '../../../../../SharedComponents/Model/HourPrice.dart';
import '../../../../../SharedComponents/Model/OperationDay.dart';
import '../../ViewModel/MyCourtsViewModel.dart';
import 'PriceSelectorHeader.dart';

class CourtDay extends StatefulWidget {
  double width;
  double height;
  int dayIndex;
  Court court;

  CourtDay({
    required this.width,
    required this.height,
    required this.dayIndex,
    required this.court,
  });

  @override
  State<CourtDay> createState() => _CourtDayState();
}

class _CourtDayState extends State<CourtDay> {
  bool isExpanded = false;
  double borderSize = 2;
  double editIconWidth = 50;

  TextEditingController controller = TextEditingController();
  double arrowHeight = 16;

  List<HourPrice> priceRules = [];

  @override
  void initState() {
    Provider.of<MyCourtsViewModel>(context, listen: false).isPriceStandard =
        widget.court.priceRules
                .where((priceRule) => priceRule.weekday == widget.dayIndex)
                .length ==
            1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainRowHeight = widget.height - 2 * borderSize;
    double secondaryRowHeight = mainRowHeight * 0.7;
    int numberRules = widget.court.priceRules
        .where((element) => element.weekday == widget.dayIndex)
        .toList()
        .length;
    double standardHeight =
        mainRowHeight * 2 + secondaryRowHeight + mainRowHeight;
    double customHeight =
        mainRowHeight * 2 + secondaryRowHeight + numberRules * mainRowHeight;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isExpanded
          ? Provider.of<MyCourtsViewModel>(context).isPriceStandard
              ? standardHeight + borderSize + arrowHeight
              : customHeight + borderSize + arrowHeight
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
                        ? Provider.of<MyCourtsViewModel>(context)
                                .isPriceStandard
                            ? standardHeight
                            : customHeight
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
                            day: widget.dayIndex,
                            hourPriceList: widget.court.prices
                                .where((hourPrice) =>
                                    hourPrice.weekday == widget.dayIndex)
                                .toList(),
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
                                        height: mainRowHeight,
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
                                                PriceSelectorRadio(
                                                    height: secondaryRowHeight,
                                                    isPriceStandard: Provider
                                                            .of<MyCourtsViewModel>(
                                                                context)
                                                        .isPriceStandard,
                                                    onChange: (value) {
                                                      Provider.of<MyCourtsViewModel>(
                                                              context,
                                                              listen: false)
                                                          .setIsPriceStandart(
                                                              value!,
                                                              widget.dayIndex);
                                                    }),
                                              ],
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: secondaryRowHeight,
                                                    child: PriceSelectorHeader(
                                                      allowRecurrent: widget
                                                          .court.prices
                                                          .firstWhere(
                                                              (hourPrice) =>
                                                                  hourPrice
                                                                      .weekday ==
                                                                  widget
                                                                      .dayIndex)
                                                          .allowReccurrent,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: widget
                                                          .court.priceRules
                                                          .where((element) =>
                                                              element.weekday ==
                                                              widget.dayIndex)
                                                          .toList()
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return PriceSelector(
                                                          allowRecurrent: widget
                                                              .court.prices
                                                              .firstWhere((hourPrice) =>
                                                                  hourPrice
                                                                      .weekday ==
                                                                  widget
                                                                      .dayIndex)
                                                              .allowReccurrent,
                                                          dayIndex:
                                                              widget.dayIndex,
                                                          priceRule: widget
                                                              .court.priceRules
                                                              .where((element) =>
                                                                  element
                                                                      .weekday ==
                                                                  widget
                                                                      .dayIndex)
                                                              .toList()[index],
                                                          height: mainRowHeight,
                                                          availableHours:
                                                              Provider.of<DataProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .availableHours
                                                                  .where(
                                                                      (hour) {
                                                            OperationDay validDay = Provider.of<
                                                                        DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .operationDays
                                                                .firstWhere((opDay) =>
                                                                    opDay
                                                                        .weekDay ==
                                                                    widget
                                                                        .dayIndex);
                                                            return hour.hour >=
                                                                    validDay
                                                                        .startingHour
                                                                        .hour &&
                                                                hour.hour <=
                                                                    validDay
                                                                        .endingHour
                                                                        .hour;
                                                          }).toList(),
                                                          editHour: !Provider
                                                                  .of<MyCourtsViewModel>(
                                                                      context)
                                                              .isPriceStandard,
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
