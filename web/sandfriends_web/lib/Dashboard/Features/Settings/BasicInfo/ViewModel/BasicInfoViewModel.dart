import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:provider/provider.dart';

import '../../../../ViewModel/DataProvider.dart';

class BasicInfoViewModel extends ChangeNotifier {
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

  void setBasicInfoFields(BuildContext context) {
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
  }

  bool basicInfoChanged(BuildContext context) {
    return nameController.text !=
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
                .uf;
  }
}
