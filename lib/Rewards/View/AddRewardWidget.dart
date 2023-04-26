import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../ViewModel/RewardsViewModel.dart';

Widget AddRewardWidget(BuildContext context) {
  final RewardsViewModel viewModel = RewardsViewModel();

  return ChangeNotifierProvider<RewardsViewModel>(
    create: (BuildContext context) => viewModel,
    child: Consumer<RewardsViewModel>(
      builder: (context, viewModel, _) {
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
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Adicione uma nova recompensa",
                          style: TextStyle(color: textBlue, fontSize: 24),
                        ),
                        SizedBox(
                          height: defaultPadding / 2,
                        ),
                        Text(
                          "Digite o código do jogador para validar a recompensa",
                          style: TextStyle(
                              color: textDarkGrey, fontSize: 16),
                        ),
                      ],
                    ),
                    SFTextField(
                        labelText: "",
                        pourpose: TextFieldPourpose.Standard,
                        controller: viewModel.addRewardController,
                        validator: ((value) {
                          return null;
                        })),
                    Row(
                      children: [
                        Expanded(
                          child: SFButton(
                            buttonLabel: "Voltar",
                            buttonType: ButtonType.Secondary,
                            onTap: (() {
                              viewModel.returnMainView(context);
                            }),
                          ),
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        Expanded(
                          child: SFButton(
                            buttonLabel: "Validar",
                            buttonType: ButtonType.Primary,
                            onTap: (() {
                              viewModel.returnMainView(context);
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
