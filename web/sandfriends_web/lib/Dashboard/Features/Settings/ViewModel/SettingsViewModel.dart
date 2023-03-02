import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image/image.dart' as IMG;
import 'package:image_picker/image_picker.dart';
import '../../../../Utils/SFImage.dart';

class SettingsViewModel extends ChangeNotifier {
  int _currentForm = 0;
  int get currentForm => _currentForm;
  set currentForm(int value) {
    _currentForm = value;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController telephoneController =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController cnpjController =
      MaskedTextController(mask: '00.000.000/0000-00');
  TextEditingController cpfController =
      MaskedTextController(mask: '000.000.000-00');
  TextEditingController storeNameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cepController = MaskedTextController(mask: '00000-000');
  TextEditingController neighbourhoodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressNumberController = TextEditingController();
  bool noCnpj = false;

  TextEditingController ownerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneOwnerController =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController descriptionController = TextEditingController();
  TextEditingController instagramController = TextEditingController();

  int _decriptionLength = 0;
  int get descriptionLength => _decriptionLength;
  set descriptionLength(int value) {
    _decriptionLength = value;
    notifyListeners();
  }

  Uint8List? _storeAvatar;
  Uint8List? get storeAvatar => _storeAvatar;
  set storeAvatar(Uint8List? newFile) {
    _storeAvatar = newFile;
    print(_storeAvatar);
    notifyListeners();
  }

  List<Uint8List> _storePhotos = [];
  List<Uint8List> get storePhotos => _storePhotos;

  void onDescriptionTextChanged() {
    descriptionLength = descriptionController.text.length;
  }

  Future setStoreAvatar(BuildContext context) async {
    XFile? pickedImage = await pickImage();
    if (pickedImage == null) return;

    IMG.Image? decodedImage = IMG.decodeImage(await pickedImage.readAsBytes());

    double aspectRatio = decodedImage!.data!.height / decodedImage.data!.width;
    IMG.Image? resizedImage;
    if (aspectRatio > 1.0) {
      resizedImage =
          await resizeImage(decodedImage, 400, (400 / aspectRatio).toInt());
    } else {
      resizedImage =
          await resizeImage(decodedImage, (400 * aspectRatio).toInt(), 400);
    }

    Uint8List? croppedImage = await cropImage(
      context,
      pickedImage,
      'circle',
      resizedImage!.height > resizedImage.width
          ? resizedImage.width
          : resizedImage.height,
      resizedImage.height > resizedImage.width
          ? resizedImage.width
          : resizedImage.height,
      resizedImage.height,
      resizedImage.width,
    );
    if (croppedImage == null) return;
    storeAvatar = croppedImage;
  }

  Future addStorePhoto(BuildContext context) async {
    XFile? pickedImage = await pickImage();
    if (pickedImage == null) return;

    IMG.Image? decodedImage = IMG.decodeImage(await pickedImage.readAsBytes());

    IMG.Image? resizedImage = await resizeImage(
      decodedImage!,
      null,
      300,
    );

    Uint8List? croppedImage = await cropImage(
      context,
      pickedImage,
      null,
      170,
      300,
      resizedImage!.height,
      resizedImage.width,
    );
    if (croppedImage == null) return;
    _storePhotos.add(croppedImage);
    notifyListeners();
  }
}
