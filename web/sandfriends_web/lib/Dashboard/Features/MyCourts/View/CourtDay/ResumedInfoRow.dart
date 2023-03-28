import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDropDown.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../SharedComponents/Model/HourPrice.dart';
import 'package:provider/provider.dart';

class ResumedInfoRow extends StatefulWidget {
  int day;
  List<HourPrice> hourPriceList;
  bool isEditing;
  bool isEnabled;
  double rowHeight;
  Function(bool) setAllowRecurrent;

  ResumedInfoRow({
    required this.day,
    required this.hourPriceList,
    required this.isEditing,
    required this.isEnabled,
    required this.rowHeight,
    required this.setAllowRecurrent,
  });
  @override
  State<ResumedInfoRow> createState() => _ResumedInfoRowState();
}

class _ResumedInfoRowState extends State<ResumedInfoRow> {
  @override
  Widget build(BuildContext context) {
    int smallestPrice = widget.hourPriceList
        .where((hourPrice) => hourPrice.weekday == widget.day)
        .reduce((current, next) => current.price < next.price ? current : next)
        .price;
    int highestPrice = widget.hourPriceList
        .where((hourPrice) => hourPrice.weekday == widget.day)
        .reduce((current, next) => current.price > next.price ? current : next)
        .price;
    int smallestPriceRecurrent = widget.hourPriceList
        .where((hourPrice) => hourPrice.weekday == widget.day)
        .reduce((current, next) =>
            current.recurrentPrice < next.recurrentPrice ? current : next)
        .recurrentPrice;
    int highestPriceRecurrent = widget.hourPriceList
        .where((hourPrice) => hourPrice.weekday == widget.day)
        .reduce((current, next) =>
            current.recurrentPrice > next.recurrentPrice ? current : next)
        .recurrentPrice;
    String priceText = smallestPrice == highestPrice
        ? "R\$$highestPrice"
        : "R\$$smallestPrice - R\$$highestPrice";
    String priceRecurrentText = smallestPriceRecurrent == highestPriceRecurrent
        ? "R\$$smallestPriceRecurrent"
        : "R\$$smallestPriceRecurrent - R\$$highestPriceRecurrent";
    if (widget.day == 0) {
      print(widget.hourPriceList
          .where((hourPrice) => hourPrice.weekday == widget.day)
          .first
          .startingHour
          .hourString);
    }
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
        widget.isEnabled
            ? Expanded(
                flex: 3,
                child: Row(
                  children: [
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
                                  onChanged: (newValue) {
                                    widget.setAllowRecurrent(newValue == "Sim");
                                  },
                                  textColor: textDarkGrey,
                                  enableBorder: true,
                                ),
                              )
                            : Text(
                                widget.hourPriceList
                                        .where((hourPrice) =>
                                            hourPrice.weekday == widget.day)
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
                                .where((hourPrice) =>
                                    hourPrice.weekday == widget.day)
                                .first
                                .allowReccurrent
                            ? "$priceText\n($priceRecurrentText)"
                            : priceText,
                        style: TextStyle(color: textDarkGrey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          Provider.of<MyCourtsViewModel>(context, listen: false)
                              .setPriceListWidget(
                                  Provider.of<MyCourtsViewModel>(context,
                                      listen: false),
                                  context,
                                  widget.hourPriceList,
                                  widget.day),
                      child: Padding(
                        padding: const EdgeInsets.only(right: defaultPadding),
                        child: SvgPicture.asset(
                          r'assets/icon/file.svg',
                          width: 20,
                          height: 20,
                          color: textDarkGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Expanded(
                flex: 3,
                child: Text(
                  "Fechado",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textDarkGrey),
                ))
      ],
    );
  }
}
