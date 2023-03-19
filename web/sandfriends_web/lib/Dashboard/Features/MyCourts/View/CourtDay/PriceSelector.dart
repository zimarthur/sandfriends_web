import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../SharedComponents/View/SFDropDown.dart';
import '../../../../../SharedComponents/View/SFTextfield.dart';

class PriceSelector extends StatefulWidget {
  TextEditingController singlePrice;
  TextEditingController recurrentPrice;
  bool editHour;
  double height;
  Hour startingHour;
  Hour endingHour;
  List<Hour> availableHours;

  PriceSelector(
      {required this.singlePrice,
      required this.recurrentPrice,
      this.editHour = false,
      required this.height,
      required this.startingHour,
      required this.endingHour,
      required this.availableHours});

  @override
  State<PriceSelector> createState() => _PriceSelectorState();
}

class _PriceSelectorState extends State<PriceSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                        labelText: widget.startingHour.hourString,
                        items: widget.availableHours
                            .where((hour) => hour.hour < widget.endingHour.hour)
                            .map((hour) => hour.hourString)
                            .toList(),
                        validator: (a) {},
                        onChanged: (a) {
                          setState(() {
                            widget.startingHour = widget.availableHours
                                .firstWhere(
                                    (element) => element.hourString == a);
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
                        labelText: widget.startingHour.hourString,
                        items: widget.availableHours
                            .where((hour) => hour.hour < widget.endingHour.hour)
                            .map((hour) => hour.hourString)
                            .toList(),
                        validator: (a) {},
                        onChanged: (a) {
                          setState(() {
                            widget.startingHour = widget.availableHours
                                .firstWhere(
                                    (element) => element.hourString == a);
                          });
                        },
                      ),
                    ),
                  ],
                )
              : Text(
                  "${widget.startingHour.hourString} - ${widget.endingHour.hourString}",
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
              controller: widget.singlePrice,
              validator: (value) {},
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
              controller: widget.recurrentPrice,
              validator: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
