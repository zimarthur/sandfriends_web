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
  final String addEmployee = "/AddEmployee";
  final String changeEmployeeAdmin = "/SetEmployeeAdmin";
  final String renameEmployee = "/RenameEmployee";
  final String removeEmployee = "/RemoveEmployee";

  final String createAccountEmployee = "/AddEmployeeInformation";

  //myCourts
  final String addCourt = "/AddCourt";
  final String removeCourt = "/RemoveCourt";
  final String saveCourtChanges = "/SaveCourtChanges";
}
