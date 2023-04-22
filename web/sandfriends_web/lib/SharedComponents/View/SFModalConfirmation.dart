import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'SFButton.dart';

class SFModalConfirmation extends StatefulWidget {
  String title;
  String description;
  VoidCallback onContinue;
  VoidCallback onReturn;

  SFModalConfirmation({super.key, 
    required this.title,
    required this.description,
    required this.onContinue,
    required this.onReturn,
  });

  @override
  State<SFModalConfirmation> createState() => _SFModalConfirmationState();
}

class _SFModalConfirmationState extends State<SFModalConfirmation> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(2 * defaultPadding),
      width: width * 0.3 < 350 ? 350 : width * 0.3,
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
          Text(
            widget.title,
            style: const TextStyle(color: textBlack, fontSize: 24),
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          Text(
            widget.description,
            style: const TextStyle(color: textDarkGrey, fontSize: 16),
          ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
          Row(
            children: [
              Expanded(
                child: SFButton(
                  buttonLabel: "Não",
                  buttonType: ButtonType.Secondary,
                  onTap: widget.onReturn,
                ),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: SFButton(
                  buttonLabel: "Sim",
                  buttonType: ButtonType.Secondary,
                  onTap: widget.onContinue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
