import 'dart:convert';

class CreateAccountStore {
  String cnpj;
  String name;
  String cep;
  String state;
  String city;
  String neighborhood;
  String street;
  String number;
  String ownerFirstName;
  String ownerLastName;
  String email;
  String cpf;
  String telephone;
  String telephoneOwner;

  CreateAccountStore({
    required this.cnpj,
    required this.name,
    required this.cep,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.number,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.email,
    required this.cpf,
    required this.telephone,
    required this.telephoneOwner,
  });
}

String CreateAccountStoreToJson(CreateAccountStore store) {
  return jsonEncode(
    <String, Object>{
      "CNPJ": store.cnpj,
      "Name": store.name,
      "CEP": store.cep,
      "State": store.state,
      "City": store.city,
      "Neighbourhood": store.neighborhood,
      "Address": "${store.street} ${store.number}",
      "OwnerFirstName": store.ownerFirstName,
      "OwnerLastName": store.ownerLastName,
      "Email": store.email,
      "CPF": store.cpf,
      "Telephone": store.telephone,
      "TelephoneOwner": store.telephoneOwner,
    },
  );
}