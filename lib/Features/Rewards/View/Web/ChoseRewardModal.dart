import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/RewardItem.dart';

import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../Utils/Constants.dart';

class ChoseRewardModal extends StatefulWidget {
  List<RewardItem> rewardItems;
  VoidCallback onReturn;
  Function(RewardItem) onTapRewardItem;
  ChoseRewardModal({
    required this.rewardItems,
    required this.onReturn,
    required this.onTapRewardItem,
  });

  @override
  State<ChoseRewardModal> createState() => _ChoseRewardModalState();
}

class _ChoseRewardModalState extends State<ChoseRewardModal> {
  @override
  int? selectedRewardIndex;
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 500,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Qual recompensa o jogador vai escolher?",
            style: TextStyle(color: textBlue, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: ListView.builder(
              itemCount: widget.rewardItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedRewardIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: defaultPadding / 2,
                      horizontal: defaultPadding,
                    ),
                    margin: EdgeInsets.only(
                      bottom: defaultPadding,
                    ),
                    decoration: BoxDecoration(
                      color: secondaryPaper,
                      borderRadius: BorderRadius.circular(
                        defaultBorderRadius,
                      ),
                      border: selectedRewardIndex == index
                          ? Border.all(color: primaryBlue, width: 3)
                          : Border.all(
                              color: textDarkGrey,
                              width: 1,
                            ),
                    ),
                    child: Text(
                      widget.rewardItems[index].description,
                      style: TextStyle(
                        color: selectedRewardIndex == index
                            ? primaryBlue
                            : textDarkGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          )),
          Row(
            children: [
              Expanded(
                child: SFButton(
                  buttonLabel: "Voltar",
                  buttonType: ButtonType.Secondary,
                  onTap: (() {
                    widget.onReturn();
                  }),
                ),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: SFButton(
                  buttonLabel: "Registrar",
                  buttonType: selectedRewardIndex == null
                      ? ButtonType.Disabled
                      : ButtonType.Primary,
                  onTap: (() {
                    if (selectedRewardIndex != null) {
                      widget.onTapRewardItem(
                          widget.rewardItems[selectedRewardIndex!]);
                    }
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
