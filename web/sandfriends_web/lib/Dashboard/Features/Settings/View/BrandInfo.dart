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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Descrição",
                      style: TextStyle(
                        color: textDarkGrey,
                        fontWeight: FontWeight.bold,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SFTextField(
                      labelText: "",
                      pourpose: TextFieldPourpose.Multiline,
                      controller: viewModel.descriptionController,
                      validator: (a) {},
                      minLines: 5,
                      maxLines: 5,
                      hintText:
                          "Fale sobre seu estabelecimento, infraestrutura, estacionamento...",
                      onChanged: (p0) => viewModel.onDescriptionTextChanged(),
                    ),
                    Text(
                      "${viewModel.descriptionLength}/255",
                      style: TextStyle(color: textDarkGrey),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Instagram",
                  style: TextStyle(
                    color: textDarkGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: SFTextField(
                        controller: viewModel.instagramController,
                        labelText: "",
                        pourpose: TextFieldPourpose.Standard,
                        validator: (value) {},
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      Container(
        width: double.infinity,
        height: 1,
        color: divider,
        margin: EdgeInsets.symmetric(vertical: defaultPadding),
      ),
    ],
  );
}
