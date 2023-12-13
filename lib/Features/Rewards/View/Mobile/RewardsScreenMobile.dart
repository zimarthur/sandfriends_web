import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Rewards/ViewModel/RewardsViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';

import '../../../../Utils/Constants.dart';
import '../../../Menu/View/Mobile/SFStandardHeader.dart';

class RewardsScreenMobile extends StatefulWidget {
  const RewardsScreenMobile({super.key});

  @override
  State<RewardsScreenMobile> createState() => _RewardsScreenMobileState();
}

class _RewardsScreenMobileState extends State<RewardsScreenMobile> {
  final RewardsViewModel viewModel = RewardsViewModel();
  final playerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RewardsViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<RewardsViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: secondaryBack,
            child: Column(
              children: [
                SFStandardHeader(
                  title: "Recompensas",
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: defaultPadding / 4,
                        horizontal: defaultPadding / 2),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SFTextField(
                                labelText: "Pesquisar jogador",
                                pourpose: TextFieldPourpose.Standard,
                                controller: playerController,
                                validator: (value) {},
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  defaultBorderRadius,
                                ),
                                color: secondaryPaper,
                              ),
                              child: Text(
                                "Hoje",
                                style: TextStyle(
                                  color: textDarkGrey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
