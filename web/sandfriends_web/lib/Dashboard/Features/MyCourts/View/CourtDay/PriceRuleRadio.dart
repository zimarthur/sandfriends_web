import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/constants.dart';

class PriceSelectorRadio extends StatefulWidget {
  bool isPriceStandard;
  double height;
  Function(bool?) onChange;

  PriceSelectorRadio({
    required this.isPriceStandard,
    required this.height,
    required this.onChange,
  });

  @override
  State<PriceSelectorRadio> createState() => _PriceSelectorRadioState();
}

class _PriceSelectorRadioState extends State<PriceSelectorRadio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio(
              value: true,
              groupValue: widget.isPriceStandard,
              onChanged: widget.onChange,
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
        Row(
          children: [
            Radio(
              value: false,
              groupValue: widget.isPriceStandard,
              onChanged: widget.onChange,
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
      ],
    );
  }
}
