import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';
import 'SFButton.dart';

class SFMessageModal extends StatefulWidget {
  String message;
  VoidCallback onTap;
  String buttonText;
  bool isHappy;
  bool hideButton;

  SFMessageModal({
    super.key,
    required this.message,
    required this.onTap,
    this.buttonText = "Voltar",
    required this.isHappy,
    this.hideButton = false,
  });

  @override
  State<SFMessageModal> createState() => _SFMessageModalState();
}

class _SFMessageModalState extends State<SFMessageModal> {
  late String title;
  late String? description;

  @override
  void initState() {
    if (widget.message.contains(titleDescriptionSeparator)) {
      title = widget.message.split(titleDescriptionSeparator)[0];
      description = widget.message.split(titleDescriptionSeparator)[1];
    } else {
      title = widget.message;
      description = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(2 * defaultPadding),
      width: Responsive.isMobile(context)
          ? width * 0.8
          : width * 0.3 < 350
              ? 350
              : width * 0.3,
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            widget.isHappy
                ? r"assets/icon/happy_face.svg"
                : r"assets/icon/sad_face.svg",
            height: Responsive.isMobile(context) ? 80 : 100,
          ),
          const SizedBox(
            height: 2 * defaultPadding,
          ),
          Text(
            title,
            style: TextStyle(
                color: textBlack,
                fontSize: Responsive.isMobile(context) ? 18 : 24),
          ),
          if (description != null)
            Column(
              children: [
                const SizedBox(
                  height: defaultPadding / 2,
                ),
                Text(
                  description!,
                  style: TextStyle(
                      color: textDarkGrey,
                      fontSize: Responsive.isMobile(context) ? 14 : 16),
                ),
              ],
            ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
          if (!widget.hideButton)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.3 < 350 ? 35 : width * 0.03),
              child: SFButton(
                  buttonLabel: widget.buttonText,
                  buttonType: ButtonType.Primary,
                  onTap: widget.onTap),
            )
        ],
      ),
    );
  }
}
