import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

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

  void onDescriptionTextChanged() {
    descriptionLength = descriptionController.text.length;
  }
}
