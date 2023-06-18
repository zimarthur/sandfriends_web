import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Settings/EmployeeInfo/ViewModel/EmployeeInfoViewModel.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as IMG;
import 'package:flutter/foundation.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sandfriends_web/Features/Settings/Repository/SettingsRepoImp.dart';
import 'package:sandfriends_web/SharedComponents/Model/StorePhoto.dart';
import 'package:sandfriends_web/Utils/Numbers.dart';
import '../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Store.dart';
import '../../../SharedComponents/View/SFMessageModal.dart';
import '../../../Utils/PageStatus.dart';
import '../../../Utils/SFImage.dart';
import '../../Menu/ViewModel/DataProvider.dart';
import '../../Menu/ViewModel/MenuProvider.dart';

class SettingsViewModel extends ChangeNotifier {
  final settingsRepo = SettingsRepoImp();

  int _currentForm = 0;
  int get currentForm => _currentForm;
  set currentForm(int value) {
    _currentForm = value;
    notifyListeners();
  }

  List<String> get formsTitle =>
      ["Dados básicos", "Marca", "Dados financeiros", "Equipe"];

  late Store storeRef;
  late Store storeEdit;

  bool hasChangedPhoto = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController telephoneController =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController cnpjController =
      MaskedTextController(mask: '00.000.000/0000-00');
  TextEditingController cpfController =
      MaskedTextController(mask: '000.000.000-00');
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController cepController = MaskedTextController(mask: '00000-000');
  TextEditingController neighbourhoodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressNumberController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController telephoneOwnerController =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController descriptionController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();

  int get descriptionLength =>
      storeEdit.description == null ? 0 : storeEdit.description!.length;

  Uint8List? storeAvatarRef;

  Uint8List? _storeAvatar;
  Uint8List? get storeAvatar => _storeAvatar;
  set storeAvatar(Uint8List? newFile) {
    _storeAvatar = newFile;
    notifyListeners();
  }

  void initSettingsViewModel(BuildContext context) {
    storeRef = Store.copyWith(
        Provider.of<DataProvider>(context, listen: false).store!);
    storeEdit = Store.copyWith(
        Provider.of<DataProvider>(context, listen: false).store!);
    nameController.text = storeEdit.name;
    telephoneController.text = storeEdit.phoneNumber;
    telephoneOwnerController.text = storeEdit.ownerPhoneNumber ?? "";
    cepController.text = storeEdit.cep;
    neighbourhoodController.text = storeEdit.neighbourhood;
    addressController.text = storeEdit.address;
    addressNumberController.text = storeEdit.addressNumber;
    cityController.text = storeEdit.city.name;
    stateController.text = storeEdit.city.state.uf;
    descriptionController.text = storeEdit.description ?? "";
    instagramController.text = storeEdit.instagram ?? "";
    notifyListeners();
  }

  bool get infoChanged =>
      storeRef.name != storeEdit.name ||
      storeRef.phoneNumber != storeEdit.phoneNumber ||
      storeRef.ownerPhoneNumber != storeEdit.ownerPhoneNumber ||
      storeRef.cep != storeEdit.cep ||
      storeRef.address != storeEdit.address ||
      storeRef.addressNumber != storeEdit.addressNumber ||
      storeRef.city.name != storeEdit.city.name ||
      storeRef.city.state.uf != storeEdit.city.state.uf ||
      storeRef.neighbourhood != storeEdit.neighbourhood ||
      storeRef.description != storeEdit.description ||
      storeRef.instagram != storeEdit.instagram ||
      storeRef.bankAccount != storeEdit.bankAccount ||
      storeRef.cnpj != storeEdit.cnpj ||
      storeAvatar != null ||
      hasChangedPhoto;

  void updateUser(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).setModalLoading();
    if (storeAvatar != null) {
      storeEdit.logo = base64Encode(storeAvatar!);
    }

    settingsRepo.updateStoreInfo(storeEdit).then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        Map<String, dynamic> responseBody = json.decode(
          response.responseBody!,
        );
        Provider.of<DataProvider>(context, listen: false).store =
            Store.fromJson(
          responseBody["Store"],
        );
        initSettingsViewModel(context);
        hasChangedPhoto = false;
        storeAvatar = null;
        Provider.of<MenuProvider>(context, listen: false).setMessageModal(
          "Seus dados foram atualizados!",
          null,
          true,
        );
      } else {
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModalFromResponse(
          response,
        );
      }
    });
  }

  Future setStoreAvatar(BuildContext context) async {
    XFile? pickedImage = await pickImage();
    if (pickedImage == null) return;

    IMG.Image? decodedImage = IMG.decodeImage(await pickedImage.readAsBytes());

    double aspectRatio = decodedImage!.data!.height / decodedImage.data!.width;
    IMG.Image? resizedImage;
    if (aspectRatio > 1.0) {
      resizedImage = await resizeImage(decodedImage, 400, 400 ~/ aspectRatio);
    } else {
      resizedImage =
          await resizeImage(decodedImage, (400 * aspectRatio).toInt(), 400);
    }

    Uint8List? croppedImage = await cropImage(
      context,
      pickedImage,
      'square',
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
    storeEdit.photos.add(
      StorePhoto(
        idStorePhoto: storeEdit.photos.isEmpty
            ? 0
            : storeEdit.photos
                    .reduce((a, b) => a.idStorePhoto > b.idStorePhoto ? a : b)
                    .idStorePhoto +
                1,
        photo: "",
        isNewPhoto: true,
        newPhoto: croppedImage,
      ),
    );
    hasChangedPhoto = true;
    notifyListeners();
  }

  void deleteStorePhoto(int idStorePhoto) {
    storeEdit.photos.removeWhere(
      (element) => element.idStorePhoto == idStorePhoto,
    );
    hasChangedPhoto = true;
    notifyListeners();
  }

  void onChangedName(String newValue) {
    storeEdit.name = newValue;
    notifyListeners();
  }

  void onChangedPhoneNumber(String newValue) {
    storeEdit.phoneNumber = getRawNumber(newValue);
    notifyListeners();
  }

  void onChangedOwnerPhoneNumber(String newValue) {
    storeEdit.ownerPhoneNumber = getRawNumber(newValue);
    notifyListeners();
  }

  void onChangedCep(String newValue) {
    storeEdit.cep = getRawNumber(newValue);
    notifyListeners();
  }

  void onChangedAddress(String newValue) {
    storeEdit.address = newValue;
    notifyListeners();
  }

  void onChangedAddressNumber(String newValue) {
    storeEdit.addressNumber = newValue;
    notifyListeners();
  }

  void onChangedNeighbourhood(String newValue) {
    storeEdit.neighbourhood = newValue;
    notifyListeners();
  }

  void onChangedCity(String newValue) {
    storeEdit.city.name = newValue;
    notifyListeners();
  }

  void onChangedState(String newValue) {
    storeEdit.city.state.uf = newValue;
    notifyListeners();
  }

  void onChangedDescription(String newValue) {
    storeEdit.description = newValue;
    notifyListeners();
  }

  void onChangedInstagram(String newValue) {
    storeEdit.instagram = newValue;
    notifyListeners();
  }

  void onChangedBankAccount(String newValue) {
    storeEdit.bankAccount = newValue;
    notifyListeners();
  }

  void onChangedCnpj(String newValue) {
    storeEdit.cnpj = getRawNumber(newValue);
    notifyListeners();
  }
}
