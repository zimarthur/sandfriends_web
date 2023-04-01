import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';

class CourtInfo extends StatefulWidget {
  MyCourtsViewModel viewModel;
  CourtInfo({
    required this.viewModel,
  });

  @override
  State<CourtInfo> createState() => _CourtInfoState();
}

class _CourtInfoState extends State<CourtInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: secondaryBack,
          border: Border.all(
            color: divider,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(defaultBorderRadius)),
      padding: EdgeInsets.all(
        defaultPadding,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: defaultPadding / 4,
            ),
            child: Text(
              "Informações",
              style: TextStyle(
                color: primaryBlue,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: defaultPadding,
            ),
            child: SFDivider(),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Nome da quadra",
                              style: TextStyle(
                                color: textDarkGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SFTextField(
                              labelText: "",
                              pourpose: TextFieldPourpose.Standard,
                              controller: widget.viewModel.nameController,
                              validator: (value) {},
                              onChanged: (newText) {
                                if (widget.viewModel.selectedCourtIndex == -1) {
                                  widget.viewModel.newCourtName = newText;
                                } else {
                                  widget
                                      .viewModel
                                      .courts[
                                          widget.viewModel.selectedCourtIndex]
                                      .description = newText;
                                }
                                widget.viewModel.checkCourtInfoChanges(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2 * defaultPadding,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Tipo",
                              style: TextStyle(
                                color: textDarkGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: true,
                                      groupValue: widget.viewModel
                                                  .selectedCourtIndex ==
                                              -1
                                          ? widget.viewModel.newCourtIsIndoor
                                          : widget
                                              .viewModel
                                              .courts[widget
                                                  .viewModel.selectedCourtIndex]
                                              .isIndoor,
                                      onChanged: (value) {
                                        if (widget
                                                .viewModel.selectedCourtIndex ==
                                            -1) {
                                          widget.viewModel.newCourtIsIndoor =
                                              value!;
                                        } else {
                                          widget
                                              .viewModel
                                              .courts[widget
                                                  .viewModel.selectedCourtIndex]
                                              .isIndoor = value!;
                                        }

                                        widget.viewModel
                                            .checkCourtInfoChanges(context);
                                      },
                                    ),
                                    SizedBox(
                                      width: defaultPadding,
                                    ),
                                    Text(
                                      "Coberta",
                                      style: TextStyle(
                                        color: textDarkGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: false,
                                      groupValue: widget.viewModel
                                                  .selectedCourtIndex ==
                                              -1
                                          ? widget.viewModel.newCourtIsIndoor
                                          : widget
                                              .viewModel
                                              .courts[widget
                                                  .viewModel.selectedCourtIndex]
                                              .isIndoor,
                                      onChanged: (value) {
                                        if (widget
                                                .viewModel.selectedCourtIndex ==
                                            -1) {
                                          widget.viewModel.newCourtIsIndoor =
                                              value!;
                                        } else {
                                          widget
                                              .viewModel
                                              .courts[widget
                                                  .viewModel.selectedCourtIndex]
                                              .isIndoor = value!;
                                        }

                                        widget.viewModel
                                            .checkCourtInfoChanges(context);
                                      },
                                    ),
                                    SizedBox(
                                      width: defaultPadding,
                                    ),
                                    Text(
                                      "Descoberta",
                                      style: TextStyle(
                                        color: textDarkGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2 * defaultPadding,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Esportes:",
                              style: TextStyle(
                                color: textDarkGrey,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(defaultPadding),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  defaultBorderRadius,
                                ),
                                border: Border.all(
                                  color: divider,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  for (int sportIndex = 0;
                                      sportIndex <
                                          Provider.of<DataProvider>(context,
                                                  listen: false)
                                              .availableSports
                                              .length;
                                      sportIndex++)
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: widget.viewModel
                                                      .selectedCourtIndex ==
                                                  -1
                                              ? widget
                                                  .viewModel
                                                  .newCourtSports[sportIndex]
                                                  .isAvailable
                                              : widget
                                                  .viewModel
                                                  .courts[widget.viewModel
                                                      .selectedCourtIndex]
                                                  .sports[sportIndex]
                                                  .isAvailable,
                                          onChanged: (newValue) {
                                            if (widget.viewModel
                                                    .selectedCourtIndex ==
                                                -1) {
                                              widget
                                                  .viewModel
                                                  .newCourtSports[sportIndex]
                                                  .isAvailable = newValue!;
                                            } else {
                                              widget
                                                  .viewModel
                                                  .courts[widget.viewModel
                                                      .selectedCourtIndex]
                                                  .sports[sportIndex]
                                                  .isAvailable = newValue!;
                                            }

                                            widget.viewModel
                                                .checkCourtInfoChanges(context);
                                          },
                                        ),
                                        SizedBox(
                                          width: defaultPadding,
                                        ),
                                        Text(
                                          widget.viewModel.selectedCourtIndex ==
                                                  -1
                                              ? widget
                                                  .viewModel
                                                  .newCourtSports[sportIndex]
                                                  .sport
                                                  .description
                                              : widget
                                                  .viewModel
                                                  .courts[widget.viewModel
                                                      .selectedCourtIndex]
                                                  .sports[sportIndex]
                                                  .sport
                                                  .description,
                                          style: TextStyle(
                                            color: textDarkGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          widget.viewModel.selectedCourtIndex == -1
              ? SFButton(
                  buttonLabel: "Adicionar quadra",
                  buttonType: ButtonType.Primary,
                  onTap: () {
                    widget.viewModel.addCourt(context);
                  },
                )
              : SFButton(
                  buttonLabel: "Excluir quadra",
                  buttonType: ButtonType.Delete,
                  onTap: () {
                    widget.viewModel.deleteCourt(context);
                  },
                )
        ],
      ),
    );
  }
}
