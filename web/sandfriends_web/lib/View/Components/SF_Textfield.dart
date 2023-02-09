import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/constants.dart';

enum TextFieldPourpose { Standard, Email, Password, Numeric, Multiline }

class SFTextField extends StatefulWidget {
  final String labelText;
  final SvgPicture? prefixIcon;
  final SvgPicture? suffixIcon;
  final SvgPicture? suffixIconPressed;
  final TextFieldPourpose pourpose;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final bool enable;

  const SFTextField({
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconPressed,
    required this.pourpose,
    required this.controller,
    required this.validator,
    this.maxLines,
    this.onChanged,
    this.minLines,
    this.enable = true,
  });

  @override
  State<SFTextField> createState() => _SFTextFieldState();
}

class _SFTextFieldState extends State<SFTextField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable,
      validator: widget.validator,
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      keyboardType: widget.pourpose == TextFieldPourpose.Email
          ? TextInputType.emailAddress
          : widget.pourpose == TextFieldPourpose.Numeric
              ? TextInputType.number
              : widget.pourpose == TextFieldPourpose.Multiline
                  ? TextInputType.multiline
                  : TextInputType.text,
      obscureText: widget.pourpose != TextFieldPourpose.Password
          ? false
          : _passwordVisible
              ? false
              : true,
      onChanged: widget.onChanged ?? (value) {},
      minLines: widget.minLines ?? 1,
      maxLines:
          widget.pourpose == TextFieldPourpose.Multiline ? widget.maxLines : 1,
      enableSuggestions: false,
      autocorrect: false,
      style: TextStyle(
        color: primaryBlue,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.enable ? secondaryPaper : disabled,
        contentPadding: const EdgeInsets.all(16),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: textDarkGrey,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        prefixIcon: widget.prefixIcon == null
            ? null
            : Container(
                padding: const EdgeInsets.all(16),
                child: widget.prefixIcon,
              ),
        suffixIcon: widget.suffixIcon == null
            ? null
            : InkWell(
                onTap: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: _passwordVisible
                      ? widget.suffixIconPressed
                      : widget.suffixIcon,
                ),
              ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 2,
            color: divider,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 2,
            color: divider,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 2,
            color: primaryBlue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}
