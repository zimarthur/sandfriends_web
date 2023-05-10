class ApiEndPoints {
  final String createAccount = "/AddStore";
  final String login = "/StoreLogin";
  final String forgotPassword = "/ChangePasswordRequestEmployee";
  final String changePasswordValidateTokenEmployee =
      "/ValidateChangePasswordTokenEmployee";
  final String changePasswordEmployee = "/ChangePasswordEmployee";

  //add employee
  final String validateNewEmployeeToken = "/ValidateNewEmployeeToken";
  final String createAccountEmployee = "/AddStoreEmployee";
  final String emailConfirmationStore = "/EmailConfirmationEmployee";

  final String emailConfirmationUser = "/EmailConfirmationUser";
  final String changePasswordValidateTokenUser =
      "/ValidateChangePasswordTokenUser";
  final String changePasswordUser = "/ChangePasswordUser";
}
