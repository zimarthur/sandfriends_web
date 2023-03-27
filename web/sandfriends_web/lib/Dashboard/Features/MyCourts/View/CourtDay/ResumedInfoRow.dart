import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDropDown.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';

import '../../../../../SharedComponents/Model/HourPrice.dart';

class ResumedInfoRow extends StatefulWidget {
  int day;
  List<HourPrice> hourPriceList;
  bool isEditing;
  double rowHeight;

  ResumedInfoRow({
    required this.day,
    required this.hourPriceList,
    required this.isEditing,
    required this.rowHeight,
  });
  @override
  State<ResumedInfoRow> createState() => _ResumedInfoRowState();
}

class _ResumedInfoRowState extends State<ResumedInfoRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            weekday[widget.day],
            style: TextStyle(color: textDarkGrey),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${widget.hourPriceList.where((hourPrice) => hourPrice.weekday == widget.day).first.startingHour.hourString} - ${widget.hourPriceList.where((hourPrice) => hourPrice.weekday == widget.day).last.endingHour.hourString}",
            style: TextStyle(color: textDarkGrey),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.center,
            child: widget.isEditing
                ? SizedBox(
                    height: widget.rowHeight * 0.7,
                    child: SFDropdown(
                      labelText: widget.hourPriceList
                              .where((hourPrice) =>
                                  hourPrice.weekday == widget.day)
                              .first
                              .allowReccurrent
                          ? "Sim"
                          : "Não",
                      items: ["Sim", "Não"],
                      validator: (value) {},
                      onChanged: (value) {
                        setState(() {
                          widget.hourPriceList
                              .where((hourPrice) =>
                                  hourPrice.weekday == widget.day)
                              .forEach((element) =>
                                  element.allowReccurrent = value == "Sim");
                        });
                      },
                      textColor: textDarkGrey,
                      enableBorder: true,
                    ),
                  )
                : Text(
                    widget.hourPriceList
                            .where(
                                (hourPrice) => hourPrice.weekday == widget.day)
                            .first
                            .allowReccurrent
                        ? "Sim"
                        : "Não",
                    style: TextStyle(color: textDarkGrey),
                  ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            widget.hourPriceList
                    .where((hourPrice) => hourPrice.weekday == widget.day)
                    .first
                    .allowReccurrent
                ? "R\$${widget.hourPriceList.where((hourPrice) => hourPrice.weekday == widget.day).reduce((current, next) => current.price < next.price ? current : next).price} - R\$${widget.hourPriceList.where((hourPrice) => hourPrice.weekday == widget.day).reduce((current, next) => current.price > next.price ? current : next).price} \n (R\$${widget.hourPriceList.where((hourPrice) => hourPrice.weekday == widget.day).reduce((current, next) => current.recurrentPrice < next.recurrentPrice ? current : next).recurrentPrice} - R\$${widget.hourPriceList.where((hourPrice) => hourPrice.weekday == widget.day).reduce((current, next) => current.recurrentPrice > next.recurrentPrice ? current : next).recurrentPrice})"
                : "R\$${widget.hourPriceList.where((hourPrice) => hourPrice.weekday == widget.day).reduce((current, next) => current.price < next.price ? current : next).price} - R\$${widget.hourPriceList.where((hourPrice) => hourPrice.weekday == widget.day).reduce((current, next) => current.price > next.price ? current : next).price}",
            style: TextStyle(color: textDarkGrey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
