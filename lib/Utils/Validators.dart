String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "digite seu e-mail";
  } else if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return null;
  } else {
    return "e-mail inválido";
  }
}

String? emptyCheck(String? value, String onNull) {
  if (value == null || value.isEmpty) {
    return onNull;
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "digite sua senha";
  } else if (RegExp(r"^.{8,}").hasMatch(value)) {
    return null;
  } else {
    return "min. 8 caracteres";
  }
}

String? max255(String? value) {
  if (value!.isNotEmpty && value.length > 255) {
    return "Máx 255 caracteres";
  } else {
    return null;
  }
}

String? cpfValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "digite seu cpf";
  } else {
    final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
    if (cleanValue.length != 11 || int.tryParse(cleanValue) == null) {
      return "cpf inválido";
    } else {
      return null;
    }
  }
}

String? cnpjValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "digite seu cnpj";
  } else {
    final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
    if (cleanValue.length != 14 || int.tryParse(cleanValue) == null) {
      return "cnpj inválido";
    } else {
      return null;
    }
  }
}

String? cepValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "digite seu cep";
  } else {
    final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
    if (cleanValue.length != 8 || int.tryParse(cleanValue) == null) {
      return "cep inválido";
    } else {
      return null;
    }
  }
}

String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "digite um número";
  } else {
    final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
    if (cleanValue.length != 11 || int.tryParse(cleanValue) == null) {
      return "número inválido";
    } else {
      return null;
    }
  }
}

String? lettersValidator(String? value, String onNull) {
  if (value == null || value.isEmpty) {
    return onNull;
  } else {
    if (RegExp(r"[^a-z ]", caseSensitive: false).allMatches(value).isNotEmpty) {
      return "formato inválido";
    } else {
      return null;
    }
  }
}
