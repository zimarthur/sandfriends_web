String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Digite seu e-mail";
  } else if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return null;
  } else {
    return "E-mail inválido";
  }
}

String? emptyCheck(String? value, String onNull) {
  if (value == null || value.isEmpty) {
    return onNull;
  } else {
    return null;
  }
}

String? rewardCodeValidator(String? value, String onNull) {
  if (value == null || value.isEmpty) {
    return onNull;
  } else if (value.length != 6) {
    return "O código deve ter 6 dígitos";
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Digite sua senha";
  } else if (RegExp(r"^.{8,}").hasMatch(value)) {
    return null;
  } else {
    return "Min. 8 caracteres";
  }
}

String? confirmPasswordValidator(String? value, String password) {
  if (value != password) {
    return "As senhas não estão iguais";
  }
  return null;
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
    return "Digite seu cpf";
  } else {
    final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
    if (cleanValue.length != 11 || int.tryParse(cleanValue) == null) {
      return "Cpf inválido";
    } else {
      return null;
    }
  }
}

String? cnpjValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Digite seu cnpj";
  } else {
    final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
    if (cleanValue.length != 14 || int.tryParse(cleanValue) == null) {
      return "Cnpj inválido";
    } else {
      return null;
    }
  }
}

String? cepValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Digite seu cep";
  } else {
    final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
    if (cleanValue.length != 8 || int.tryParse(cleanValue) == null) {
      return "Cep inválido";
    } else {
      return null;
    }
  }
}

String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Digite um número";
  } else {
    final cleanValue = value.replaceAll(RegExp('[^0-9]'), '');
    if (cleanValue.length != 11 || int.tryParse(cleanValue) == null) {
      return "Número inválido";
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
      return "Formato inválido";
    } else {
      return null;
    }
  }
}
