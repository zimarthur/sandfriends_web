import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image/image.dart' as IMG;
import 'package:image_picker/image_picker.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import '../../../../Utils/SFImage.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class SettingsViewModel extends ChangeNotifier {
  int _currentForm = 0;
  int get currentForm => _currentForm;
  set currentForm(int value) {
    _currentForm = value;
    notifyListeners();
  }

  List<String> get formsTitle =>
      ["Dados básicos", "Marca", "Dados financeiros", "Equipe"];

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
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneOwnerController =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController descriptionController = TextEditingController();
  TextEditingController instagramController = TextEditingController();

  bool _storeInfoDif = false;
  bool get storeInfoDif => _storeInfoDif;

  int _decriptionLength = 0;
  int get descriptionLength => _decriptionLength;
  set descriptionLength(int value) {
    _decriptionLength = value;
    notifyListeners();
  }

  Uint8List? storeAvatarRef;

  Uint8List? _storeAvatar;
  Uint8List? get storeAvatar => _storeAvatar;
  set storeAvatar(Uint8List? newFile) {
    _storeAvatar = newFile;
    notifyListeners();
  }

  List<Uint8List> storePhotosRef = [];
  List<Uint8List> _storePhotos = [];
  List<Uint8List> get storePhotos => _storePhotos;

  void setFields(BuildContext context) {
    nameController.text =
        Provider.of<DataProvider>(context, listen: false).store!.name;
    telephoneController.text =
        Provider.of<DataProvider>(context, listen: false).store!.phoneNumber;
    telephoneOwnerController.text =
        Provider.of<DataProvider>(context, listen: false)
                .store!
                .ownerPhoneNumber ??
            "";
    cepController.text =
        Provider.of<DataProvider>(context, listen: false).store!.cep;
    neighbourhoodController.text =
        Provider.of<DataProvider>(context, listen: false).store!.neighbourhood;
    addressController.text =
        Provider.of<DataProvider>(context, listen: false).store!.address;
    addressNumberController.text =
        Provider.of<DataProvider>(context, listen: false).store!.addressNumber;
    cityController.text =
        Provider.of<DataProvider>(context, listen: false).store!.city.name;
    stateController.text =
        Provider.of<DataProvider>(context, listen: false).store!.city.state.uf;
    descriptionController.text =
        Provider.of<DataProvider>(context, listen: false).store!.description ??
            "";
    instagramController.text =
        Provider.of<DataProvider>(context, listen: false).store!.instagram ??
            "";
    storeAvatarRef = storeAvatar;
    storePhotosRef = List.from(storePhotos);
    notifyListeners();
  }

  void storeInfoChanged(BuildContext context) {
    _storeInfoDif = nameController.text !=
            Provider.of<DataProvider>(context, listen: false).store!.name ||
        telephoneController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .phoneNumber ||
        telephoneOwnerController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .ownerPhoneNumber ||
        cepController.text !=
            Provider.of<DataProvider>(context, listen: false).store!.cep ||
        neighbourhoodController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .neighbourhood ||
        addressController.text !=
            Provider.of<DataProvider>(context, listen: false).store!.address ||
        addressNumberController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .addressNumber ||
        cityController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .city
                .name ||
        stateController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .city
                .state
                .uf ||
        descriptionController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .description ||
        instagramController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .instagram ||
        storeAvatar != storeAvatarRef ||
        listEquals(storePhotos, storePhotosRef) == false;
    notifyListeners();
  }

  void saveStoreDifChanges(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false).store!.name =
        nameController.text;
    Provider.of<DataProvider>(context, listen: false).store!.phoneNumber =
        telephoneController.text;
    Provider.of<DataProvider>(context, listen: false).store!.ownerPhoneNumber =
        telephoneOwnerController.text;
    Provider.of<DataProvider>(context, listen: false).store!.cep =
        cepController.text;
    Provider.of<DataProvider>(context, listen: false).store!.neighbourhood =
        neighbourhoodController.text;
    Provider.of<DataProvider>(context, listen: false).store!.address =
        addressController.text;
    Provider.of<DataProvider>(context, listen: false).store!.addressNumber =
        addressNumberController.text;
    Provider.of<DataProvider>(context, listen: false).store!.city.name =
        cityController.text; //tem q chegar do servidor a classe city certa
    Provider.of<DataProvider>(context, listen: false).store!.city.state.uf =
        stateController.text; //tem q chegar do servidor a classe state certa
    Provider.of<DataProvider>(context, listen: false).store!.description =
        descriptionController.text;
    Provider.of<DataProvider>(context, listen: false).store!.instagram =
        instagramController.text;
    storeAvatarRef = storeAvatar;
    storePhotosRef = List.from(storePhotos);
    storeInfoChanged(context);
  }

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
    storeInfoChanged(context);
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
    storeInfoChanged(context);
    notifyListeners();
  }

  void deleteStorePhoto(BuildContext context, int index) {
    _storePhotos.removeAt(index);
    storeInfoChanged(context);
    notifyListeners();
  }
}
