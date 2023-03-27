import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../SharedComponents/Model/HourPrice.dart';
import '../../../../../SharedComponents/Model/PriceRule.dart';
import '../../../../../SharedComponents/View/SFDropDown.dart';
import '../../../../../SharedComponents/View/SFTextfield.dart';

class PriceSelector extends StatefulWidget {
  PriceRule priceRule;
  bool editHour;
  double height;
  List<Hour> availableHours;
  int dayIndex;

  PriceSelector({
    required this.priceRule,
    this.editHour = false,
    required this.height,
    required this.availableHours,
    required this.dayIndex,
  });

  @override
  State<PriceSelector> createState() => _PriceSelectorState();
}

class _PriceSelectorState extends State<PriceSelector> {
  TextEditingController priceController = TextEditingController();
  TextEditingController recurrentPriceController = TextEditingController();

  @override
  void initState() {
    priceController.text = widget.priceRule.price.toString();
    recurrentPriceController.text = widget.priceRule.priceRecurrent.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: widget.height * 0.05,
      ),
      height: widget.height * 0.9,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: widget.editHour
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: widget.height,
                        child: SFDropdown(
                          enableBorder: true,
                          textColor: textDarkGrey,
                          labelText: widget.priceRule.startingHour.hourString,
                          items: widget.availableHours
                              .where(
                                (hour) =>
                                    hour.hour <
                                    widget.priceRule.endingHour.hour,
                              )
                              .map((hour) => hour.hourString)
                              .toList(),
                          validator: (a) {},
                          onChanged: (newHour) {
                            setState(() {
                              Provider.of<MyCourtsViewModel>(context,
                                      listen: false)
                                  .setNewRuleStartHour(widget.dayIndex,
                                      newHour!, context, widget.priceRule);
                            });
                          },
                        ),
                      ),
                      Text(
                        " - ",
                        style: TextStyle(color: textDarkGrey),
                      ),
                      SizedBox(
                        height: widget.height,
                        child: SFDropdown(
                          enableBorder: true,
                          textColor: textDarkGrey,
                          labelText: widget.priceRule.endingHour.hourString,
                          items: widget.availableHours
                              .where(
                                (hour) =>
                                    hour.hour >
                                    widget.priceRule.startingHour.hour,
                              )
                              .map((hour) => hour.hourString)
                              .toList(),
                          validator: (a) {},
                          onChanged: (newHour) {
                            setState(() {
                              Provider.of<MyCourtsViewModel>(context,
                                      listen: false)
                                  .setNewRuleEndHour(widget.dayIndex, newHour!,
                                      context, widget.priceRule);
                            });
                          },
                        ),
                      ),
                    ],
                  )
                : Text(
                    "${widget.priceRule.startingHour.hourString} - ${widget.priceRule.endingHour.hourString}",
                    style: TextStyle(color: textDarkGrey),
                    textAlign: TextAlign.center,
                  ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: SFTextField(
                textAlign: TextAlign.center,
                plainTextField: true,
                prefixText: "R\$",
                sufixText: "/hora",
                labelText: "",
                pourpose: TextFieldPourpose.Numeric,
                controller: priceController,
                validator: (value) {},
                onChanged: (newPrice) {
                  Provider.of<MyCourtsViewModel>(context, listen: false)
                      .priceChange(
                          newPrice, widget.priceRule, widget.dayIndex, false);
                },
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: SFTextField(
                textAlign: TextAlign.center,
                plainTextField: true,
                prefixText: "R\$",
                sufixText: "/hora",
                labelText: "",
                pourpose: TextFieldPourpose.Numeric,
                controller: recurrentPriceController,
                validator: (value) {},
                onChanged: (newPrice) {
                  Provider.of<MyCourtsViewModel>(context, listen: false)
                      .priceChange(
                          newPrice, widget.priceRule, widget.dayIndex, true);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
