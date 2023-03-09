import 'City.dart';
import 'Court.dart';
import 'Hour.dart';
import 'HourPrice.dart';
import 'StorePhoto.dart';

class Store {
  String name;
  String address;
  String latitude;
  String longitude;
  String phoneNumber;
  String ownerPhoneNumber;
  String description;
  String instagram;
  int hoursBeforeCancellation;
  String email;
  String cnpj;
  String cep;
  String cpf;
  String ownerName;
  String neighbourhood;
  City city;

  Hour? openingHour;
  Hour? closingHour;

  List<Court> courts = [];
  List<StorePhoto> photos = [];
  List<HourPrice> prices = [];

  Store({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
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
}
