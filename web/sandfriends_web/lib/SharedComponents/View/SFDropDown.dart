import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class SFDropdown extends StatefulWidget {
  String labelText;
  final List<String> items;
  final FormFieldValidator<String>? validator;
  final Function(String?) onChanged;
  bool isEnabled;
  Color textColor;
  bool enableBorder;

  SFDropdown({super.key, 
    required this.labelText,
    required this.items,
    required this.validator,
    required this.onChanged,
    this.isEnabled = true,
    this.textColor = textBlack,
    this.enableBorder = false,
  });

  @override
  State<SFDropdown> createState() => _SFDropdownState();
}

class _SFDropdownState extends State<SFDropdown> {
  bool onError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.enableBorder ? defaultPadding / 2 : 0),
      decoration: widget.enableBorder
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              border: Border.all(
                color: divider,
                width: 2,
              ),
            )
          : const BoxDecoration(),
      child: DropdownButton(
        value: widget.labelText,
        style: TextStyle(
          color: widget.isEnabled ? widget.textColor : textLightGrey,
          fontFamily: "Lexend",
        ),
        iconEnabledColor: widget.textColor,
        items: widget.items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: widget.onChanged,
        alignment: AlignmentDirectional.center,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        underline: Container(),
      ),
    );

    // DropdownButtonFormField(
    //   decoration: InputDecoration(
    //     labelText: widget.controller == null ? null : widget.labelText,
    //     labelStyle: TextStyle(color: textDarkGrey),
    //     fillColor: secondaryPaper,
    //     filled: true,
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(16),
    //       borderSide: BorderSide(
    //         width: 2,
    //         color: divider,
    //       ),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(16),
    //       borderSide: BorderSide(
    //         width: 2,
    //         color: primaryBlue,
    //       ),
    //     ),
    //     errorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(16),
    //       borderSide: const BorderSide(
    //         color: Colors.red,
    //         width: 2,
    //       ),
    //     ),
    //     focusedErrorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(16),
    //       borderSide: const BorderSide(
    //         color: Colors.red,
    //         width: 2,
    //       ),
    //     ),
    //   ),
    //   focusColor: primaryBlue,
    //   iconEnabledColor: primaryBlue,
    //   isExpanded: true,
    //   hint: Text(
    //     widget.labelText,
    //     style: TextStyle(
    //       color: textDarkGrey,
    //       fontWeight: FontWeight.w300,
    //       fontSize: 14,
    //     ),
    //   ),
    //   value: widget.controller,
    //   onChanged: (String? newValue) {
    //     widget.onChanged(newValue);
    //   },
    //   style: TextStyle(
    //     color: primaryBlue,
    //     fontWeight: FontWeight.w700,
    //     fontSize: 14,
    //   ),
    //   items: widget.items.map<DropdownMenuItem<String>>((String value) {
    //     return DropdownMenuItem<String>(
    //       value: value,
    //       child: Text(value),
    //     );
    //   }).toList(),
    // );
  }
}
