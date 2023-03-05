import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_platform_interface/src/models/settings.dart';
import '../ViewModel/SettingsViewModel.dart';
import 'package:image/image.dart' as IMG;
import 'package:flutter_svg/flutter_svg.dart';

class BrandInfo extends StatefulWidget {
  SettingsViewModel viewModel;

  BrandInfo({required this.viewModel});

  @override
  State<BrandInfo> createState() => _BrandInfoState();
}

class _BrandInfoState extends State<BrandInfo> {
  @override
  Widget build(BuildContext context) {
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
                    "Seu logo",
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
                        onTap: () {
                          widget.viewModel.setStoreAvatar(context);
                        },
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
                child: widget.viewModel.storeAvatar == null
                    ? CircleAvatar(
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
                      )
                    : Image.memory(
                        widget.viewModel.storeAvatar!,
                        height: 160,
                        width: 160,
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
                          controller: widget.viewModel.descriptionController,
                          validator: (a) {},
                          minLines: 5,
                          maxLines: 5,
                          hintText:
                              "Fale sobre seu estabelecimento, infraestrutura, estacionamento...",
                          onChanged: (a) {}),
                      Text(
                        "${widget.viewModel.descriptionLength}/255",
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
                          controller: widget.viewModel.instagramController,
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
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fotos da sua quadra (min 2)",
                    style: TextStyle(color: textDarkGrey),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Row(children: [
                    Expanded(
                      child: SFButton(
                        buttonLabel: "Adicionar foto",
                        buttonType: ButtonType.Secondary,
                        onTap: () {
                          widget.viewModel.addStorePhoto(context);
                        },
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
              child: widget.viewModel.storePhotos.isEmpty
                  ? Container()
                  : SizedBox(
                      height: 220,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.viewModel.storePhotos.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                height: 190,
                                width: 320,
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          defaultBorderRadius),
                                      child: Image.memory(
                                        widget.viewModel.storePhotos[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryBlue,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.asset(
                                            r'assets/icon/x.svg',
                                            color: secondaryPaper,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 2 * defaultPadding,
                              )
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
        SizedBox(
          height: 2 * defaultPadding,
        )
      ],
    );
  }
}
