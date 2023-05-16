import 'City.dart';
import 'Court.dart';
import 'HourPrice.dart';
import 'StorePhoto.dart';
import 'package:intl/intl.dart';

class Store {
  int idStore;
  String name;
  String? logo;
  String address;
  String addressNumber;
  String phoneNumber;
  String? ownerPhoneNumber;
  String? description;
  String? instagram;
  String? cnpj;
  String cep;
  String cpf;
  String? bankAccount;
  String neighbourhood;
  int? hoursBeforeCancellation;
  City city;
  DateTime approvalDate;

  List<Court> courts = [];
  List<StorePhoto> photos = [];
  List<HourPrice> prices = [];

  Store({
    required this.idStore,
    required this.name,
    required this.logo,
    required this.address,
    required this.addressNumber,
    required this.phoneNumber,
    required this.ownerPhoneNumber,
    required this.description,
    required this.instagram,
    required this.hoursBeforeCancellation,
    required this.cnpj,
    required this.cep,
    required this.bankAccount,
    required this.cpf,
    required this.neighbourhood,
    required this.city,
    required this.approvalDate,
  });

  factory Store.fromJson(Map<String, dynamic> parsedJson) {
    return Store(
        idStore: parsedJson["IdStore"],
        name: parsedJson["Name"],
        address: parsedJson["Address"],
        addressNumber: parsedJson["AddressNumber"],
        phoneNumber: parsedJson["PhoneNumber1"],
        ownerPhoneNumber: parsedJson["PhoneNumber2"],
        logo: parsedJson["Logo"],
        description: parsedJson["Description"],
        instagram: parsedJson["Instagram"],
        cnpj: parsedJson["Cnpj"],
        cep: parsedJson["Cep"],
        bankAccount: parsedJson["BankAccount"],
        neighbourhood: parsedJson["Neighbourhood"],
        cpf: parsedJson["Cpf"],
        hoursBeforeCancellation: parsedJson["HoursBeforeCancelation"],
        city: City.fromJson(
          parsedJson["City"],
        ),
        approvalDate:
            DateFormat("dd/MM/yyyy").parse(parsedJson["ApprovalDate"]));
  }

  factory Store.copyWith(Store storeRef) {
    var store = Store(
      idStore: storeRef.idStore,
      name: storeRef.name,
      logo: storeRef.logo,
      address: storeRef.address,
      addressNumber: storeRef.addressNumber,
      phoneNumber: storeRef.phoneNumber,
      ownerPhoneNumber: storeRef.ownerPhoneNumber,
      description: storeRef.description,
      instagram: storeRef.instagram,
      hoursBeforeCancellation: storeRef.hoursBeforeCancellation,
      cnpj: storeRef.cnpj,
      cep: storeRef.cep,
      bankAccount: storeRef.bankAccount,
      cpf: storeRef.cpf,
      neighbourhood: storeRef.neighbourhood,
      city: City.copyWith(storeRef.city),
      approvalDate: storeRef.approvalDate,
    );
    store.photos = storeRef.photos;
    return store;
  }
}
