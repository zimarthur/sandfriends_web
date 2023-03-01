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

class BrandInfo extends StatefulWidget {
  SettingsViewModel viewModel;

  BrandInfo({required this.viewModel});

  @override
  State<BrandInfo> createState() => _BrandInfoState();
}

class _BrandInfoState extends State<BrandInfo> {
  Uint8List? _image;
  Uint8List? resizedImg;

  Future _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
    );

    if (image == null) return;
    IMG.Image? img = IMG.decodeImage(await image.readAsBytes());
    double aspectRatio = img!.data!.height / img.data!.width;
    IMG.Image resized;
    if (aspectRatio > 1.0) {
      resized =
          IMG.copyResize(img, width: (400 / aspectRatio).toInt(), height: 400);
    } else {
      resized =
          IMG.copyResize(img, width: 400, height: (400 * aspectRatio).toInt());
    }
    resizedImg = Uint8List.fromList(IMG.encodePng(resized));

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        WebUiSettings(
          context: context,
          showZoomer: true,
          enableZoom: true,
          viewPort: CroppieViewPort(
            type: 'circle',
            height:
                resized.height > resized.width ? resized.width : resized.height,
            width:
                resized.height > resized.width ? resized.width : resized.height,
          ),
          boundary: CroppieBoundary(
            height: resized.height,
            width: resized.width,
          ),
          translations: WebTranslations(
            title: "Redimensione sua imagem",
            cancelButton: "Cancelar",
            cropButton: "Ok",
            rotateLeftTooltip: "",
            rotateRightTooltip: "",
          ),
        ),
      ],
    );

    if (croppedFile != null) {
      _image = await croppedFile.readAsBytes();
      setState(() {});
    }
  }

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
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                          //viewModel.pickFiles();
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
                child: _image == null
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
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Image.memory(
                              _image!,
                              height: 160,
                              width: 160,
                            ),
                          ],
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
                        controller: widget.viewModel.descriptionController,
                        validator: (a) {},
                        minLines: 5,
                        maxLines: 5,
                        hintText:
                            "Fale sobre seu estabelecimento, infraestrutura, estacionamento...",
                        onChanged: (p0) =>
                            widget.viewModel.onDescriptionTextChanged(),
                      ),
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
      ],
    );
  }
}
