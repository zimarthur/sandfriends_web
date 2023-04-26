import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

enum ButtonType {
  Primary,
  Secondary,
  Disabled,
  YellowPrimary,
  YellowSecondary,
  LightBluePrimary,
  LightBlueSecondary,
  Delete,
}

class SFButton extends StatefulWidget {
  final String buttonLabel;
  final ButtonType buttonType;
  final VoidCallback? onTap;
  final String iconPath;
  final double iconSize;
  final EdgeInsets? textPadding;
  final bool? iconFirst;

  const SFButton({super.key, 
    required this.buttonLabel,
    required this.buttonType,
    required this.onTap,
    this.iconPath = "",
    this.iconSize = 18,
    this.textPadding = const EdgeInsets.symmetric(vertical: 10),
    this.iconFirst = false,
  });

  @override
  State<SFButton> createState() => _SFButtonState();
}

class _SFButtonState extends State<SFButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: widget.textPadding == null
            ? const EdgeInsets.all(0)
            : widget.textPadding!,
        decoration: BoxDecoration(
          color: widget.buttonType == ButtonType.Primary
              ? primaryBlue
              : widget.buttonType == ButtonType.YellowPrimary
                  ? secondaryYellow
                  : widget.buttonType == ButtonType.LightBluePrimary
                      ? primaryLightBlue
                      : widget.buttonType == ButtonType.Delete
                          ? red
                          : widget.buttonType == ButtonType.Secondary ||
                                  widget.buttonType ==
                                      ButtonType.YellowSecondary ||
                                  widget.buttonType ==
                                      ButtonType.LightBlueSecondary
                              ? secondaryPaper
                              : textDisabled,
          borderRadius: BorderRadius.circular(16.0),
          border: widget.buttonType == ButtonType.Secondary
              ? Border.all(color: primaryBlue, width: 1)
              : widget.buttonType == ButtonType.YellowSecondary
                  ? Border.all(color: secondaryYellow, width: 1)
                  : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.iconPath == "" || widget.iconFirst == false
                ? Container()
                : Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      widget.iconPath,
                      height: widget.iconSize,
                      color: widget.buttonType == ButtonType.Secondary
                          ? primaryBlue
                          : widget.buttonType == ButtonType.YellowSecondary
                              ? secondaryYellow
                              : widget.buttonType ==
                                      ButtonType.LightBlueSecondary
                                  ? secondaryLightBlue
                                  : textWhite,
                    ),
                  ),
            FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                widget.buttonLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.buttonType == ButtonType.Secondary
                      ? primaryBlue
                      : widget.buttonType == ButtonType.YellowSecondary
                          ? secondaryYellow
                          : widget.buttonType == ButtonType.LightBlueSecondary
                              ? secondaryLightBlue
                              : textWhite,
                ),
              ),
            ),
            widget.iconPath == "" || widget.iconFirst == true
                ? Container()
                : Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                      widget.iconPath,
                      color: widget.buttonType == ButtonType.Secondary
                          ? primaryBlue
                          : widget.buttonType == ButtonType.YellowSecondary
                              ? secondaryYellow
                              : widget.buttonType ==
                                      ButtonType.LightBlueSecondary
                                  ? secondaryLightBlue
                                  : textWhite,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
