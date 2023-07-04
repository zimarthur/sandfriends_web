import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_platform_interface/src/models/settings.dart';
import 'package:image/image.dart' as IMG;
import 'package:flutter/services.dart';

Future<Uint8List?> selectImage(
  BuildContext context,
  double desiredAspectRatio,
) async {
  double windowHeigth = MediaQuery.of(context).size.height * 0.8;
  double availableHeight = windowHeigth - 150;
  double windowWidth = MediaQuery.of(context).size.width * 0.5;
  double availableWidth = windowWidth - 30;

  XFile? image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 100,
    maxHeight: availableHeight,
    maxWidth: availableWidth,
  );
  if (image == null) return null;

  IMG.Image? decodedImage = IMG.decodeImage(await image.readAsBytes());
  if (decodedImage == null) return null;
  int resizeHeight = 0;
  int resizeWidth = 0;
  int cropHeight = 0;
  int cropWidth = 0;
  final imageAspectRatio = decodedImage.width / decodedImage.height;

  // if (decodedImage.height > availableHeight ||
  //     decodedImage.width > availableWidth) {
  //   if (decodedImage.height - availableHeight >
  //       decodedImage.width - availableWidth) {
  //     resizeHeight = decodedImage.height;
  //     resizeWidth = (resizeHeight / desiredAspectRatio).toInt();
  //   } else {
  //     resizeWidth = decodedImage.width;
  //     resizeHeight = (resizeWidth * desiredAspectRatio).toInt();
  //   }
  // }

  // if (resizeWidth != 0) {
  //   IMG.Image resizedImage =
  //       IMG.copyResize(decodedImage, width: resizeWidth, height: resizeHeight);
  //   decodedImage = resizedImage;
  // }

  if (desiredAspectRatio >= imageAspectRatio) {
    cropWidth = decodedImage.width;
    cropHeight = (cropWidth / desiredAspectRatio).toInt();
  } else {
    cropHeight = decodedImage.height;
    cropWidth = (cropHeight * desiredAspectRatio).toInt();
  }

  print("aspect: ${imageAspectRatio}");
  print("Img width ${decodedImage.width}");
  print("Img heigth ${decodedImage.height}");
  print("desiredAspectRatio: ${desiredAspectRatio}");
  print("cropWidth: ${cropWidth}");
  print("cropHeight: ${cropHeight}");

  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: image.path,
    uiSettings: [
      WebUiSettings(
        context: context,
        enableZoom: true,
        enableOrientation: false,
        enableExif: false,
        viewPort: CroppieViewPort(
          type: desiredAspectRatio == 1 ? 'square' : null,
          height: cropHeight,
          width: cropWidth,
        ),
        boundary: CroppieBoundary(
          height: availableHeight.toInt(),
          width: availableWidth.toInt(),
        ),
        translations: const WebTranslations(
          title: "Redimensione sua foto",
          cancelButton: "Cancelar",
          cropButton: "Ok",
          rotateLeftTooltip: "",
          rotateRightTooltip: "",
        ),
      ),
    ],
    compressQuality: 100,
  );
  if (croppedFile == null) return null;
  return await croppedFile.readAsBytes();
}

Future<XFile?> pickImage(
  BuildContext context,
) async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 100,
    maxHeight: MediaQuery.of(context).size.height * 0.5,
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
          title: "Redimensione sua foto",
          cancelButton: "Cancelar",
          cropButton: "Ok",
          rotateLeftTooltip: "",
          rotateRightTooltip: "",
        ),
      ),
    ],
    compressQuality: 100,
  );
  if (croppedFile == null) return null;
  return await croppedFile.readAsBytes();
}
