import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/constants.dart';

class PriceRuleRadio extends StatefulWidget {
  bool isPriceStandard;
  double height;

  PriceRuleRadio({
    required this.isPriceStandard,
    required this.height,
  });

  @override
  State<PriceRuleRadio> createState() => _PriceRuleRadioState();
}

class _PriceRuleRadioState extends State<PriceRuleRadio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height,
          child: Row(
            children: [
              Radio(
                value: true,
                groupValue: widget.isPriceStandard,
                onChanged: (value) {
                  setState(() {
                    widget.isPriceStandard = value!;
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
          height: widget.height,
          child: Row(
            children: [
              Radio(
                value: false,
                groupValue: widget.isPriceStandard,
                onChanged: (value) {
                  setState(() {
                    widget.isPriceStandard = value!;
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
    );
  }
}
