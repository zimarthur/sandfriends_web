class ApiEndPoints {
  //login
  final String login = "/EmployeeLogin";
  final String validateToken = "/ValidateEmployeeAccessToken";

  //create account
  final String createAccount = "/AddStore";

  //new password
  final String forgotPassword = "/ChangePasswordRequestEmployee";
  final String changePasswordValidateTokenEmployee =
      "/ValidateChangePasswordTokenEmployee";
  final String changePasswordEmployee = "/ChangePasswordEmployee";

  final String changePasswordValidateTokenUser =
      "/ValidateChangePasswordTokenUser";
  final String changePasswordUser = "/ChangePasswordUser";

  //email confirmation
  final String emailConfirmationStore = "/EmailConfirmationEmployee";
  final String emailConfirmationUser = "/EmailConfirmationUser";

  //settings
  final String updateStoreInfo = "/UpdateStoreInfo";
  final String validateNewEmployeeToken = "/ValidateNewEmployeeEmail";
  final String createAccountEmployee = "/AddEmployeeInformation";
}
