import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class SFDropdown extends StatefulWidget {
  String labelText;
  final List<String> items;
  final FormFieldValidator<String>? validator;
  final Function(String?) onChanged;

  SFDropdown({
    required this.labelText,
    required this.items,
    required this.validator,
    required this.onChanged,
  });

  @override
  State<SFDropdown> createState() => _SFDropdownState();
}

class _SFDropdownState extends State<SFDropdown> {
  bool onError = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.labelText,
      items: widget.items.map((item) {
        return DropdownMenuItem(
          child: Text(item),
          value: item,
        );
      }).toList(),
      onChanged: widget.onChanged,
      alignment: AlignmentDirectional.center,
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      underline: Container(),
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
