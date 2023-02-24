import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import 'SettingsViewModel.dart';

Widget BrandInfo(SettingsViewModel viewModel) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "O logo da sua marca",
                  style: TextStyle(color: textDarkGrey),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Row(children: [
                  Expanded(
                    child: SFButton(
                      buttonLabel: "Escolher arquivo",
                      buttonType: ButtonType.Secondary,
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ]),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 80,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      r"assets/Arthur.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      Container(
        width: double.infinity,
        height: 1,
        color: divider,
        margin: EdgeInsets.symmetric(vertical: defaultPadding),
      ),
      Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      "Descrição",
                      style: TextStyle(
                        color: textDarkGrey,
                      ),
                    ),
                    Text(
                      "(Todos os jogadores que entrarem na sua página, verão essa descrição. Seja criativo!)",
                      style: TextStyle(
                        color: textDarkGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SFTextField(
                      labelText: "",
                      pourpose: TextFieldPourpose.Standard,
                      controller: viewModel.descriptionController,
                      validator: (a) {},
                      minLines: 5,
                      maxLines: 5,
                      hintText:
                          "Fale sobre seu estabelecimento, infraestrutura, estacionamento...",
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
