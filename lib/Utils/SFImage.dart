import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_platform_interface/src/models/settings.dart';
import 'package:image/image.dart' as IMG;
import 'package:flutter/services.dart';

Future<XFile?> pickImage() async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  if (image == null) return null;

  return image;
}

Future<IMG.Image?> resizeImage(IMG.Image image, int? height, int? width) async {
  IMG.Image resizedImage = IMG.copyResize(image, width: width, height: height);
  return resizedImage;
}

Future<Uint8List?> cropImage(
  BuildContext context,
  XFile image,
  String? viewPortType,
  int viewPortHeight,
  int viewPortWidth,
  int height,
  int width,
) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: image.path,
    uiSettings: [
      WebUiSettings(
        context: context,
        enableZoom: true,
        enableOrientation: false,
        enableExif: false,
        viewPort: CroppieViewPort(
          type: viewPortType,
          height: viewPortHeight,
          width: viewPortWidth,
        ),
        boundary: const CroppieBoundary(
          height: 400,
          width: 400,
        ),
        translations: const WebTranslations(
          title: "Redimensione sua imagem",
          cancelButton: "Cancelar",
          cropButton: "Ok",
          rotateLeftTooltip: "",
          rotateRightTooltip: "",
        ),
      ),
    ],
  );
  if (croppedFile == null) return null;
  return await croppedFile.readAsBytes();
}
