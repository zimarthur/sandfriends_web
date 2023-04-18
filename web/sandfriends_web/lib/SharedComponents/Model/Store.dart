import 'City.dart';
import 'Court.dart';
import 'Hour.dart';
import 'HourPrice.dart';
import 'StorePhoto.dart';

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
  String email;
  String? cnpj;
  String cep;
  String cpf;
  String ownerName;
  String neighbourhood;
  int? hoursBeforeCancellation;
  City city;

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
    required this.email,
    required this.cnpj,
    required this.cep,
    required this.cpf,
    required this.ownerName,
    required this.neighbourhood,
    required this.city,
  });

  factory Store.fromJson(Map<String, dynamic> parsedJson) {
    return Store(
      idStore: parsedJson["IdStore"],
      name: parsedJson["Name"],
      address: parsedJson["Address"],
      addressNumber: parsedJson["AddressNumber"],
      email: parsedJson["Email"],
      phoneNumber: parsedJson["PhoneNumber1"],
      ownerPhoneNumber: parsedJson["PhoneNumber2"],
      logo: parsedJson["Logo"],
      description: parsedJson["Description"],
      instagram: parsedJson["Instagram"],
      cnpj: parsedJson["Cnpj"],
      cep: parsedJson["Cep"],
      neighbourhood: parsedJson["Neighbourhood"],
      cpf: parsedJson["Cpf"],
      ownerName: parsedJson["OwnerName"],
      hoursBeforeCancellation: parsedJson["HoursBeforeCancelation"],
      city: City.fromJson(
        parsedJson["City"],
      ),
    );
  }
}
