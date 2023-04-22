import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/EmployeeInfo/View/RenameEmployeeWidget.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DashboardViewModel.dart';
import '../../../../../SharedComponents/Model/Employee.dart';
import '../../../../ViewModel/DataProvider.dart';
import '../Model/EmployeeDataSource.dart';
import '../Model/EmployeeTableCallbacks.dart';
import '../View/AddEmployeeWidget.dart';

class EmployeeInfoViewModel extends ChangeNotifier {
  EmployeeDataSource? employeesDataSource;

  void setFinancesDataSource(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false).employees.forEach(
          (element) => print(element.email),
        );
    employeesDataSource = EmployeeDataSource(
        employees: Provider.of<DataProvider>(context, listen: false).employees,
        tableCallback: tableCallback,
        context: context);
  }

  void tableCallback(
    EmployeeTableCallbacks callbackCode,
    Employee employee,
    BuildContext context,
  ) {
    switch (callbackCode) {
      case EmployeeTableCallbacks.Rename:
        Provider.of<DashboardViewModel>(context, listen: false)
            .setModalForm(RenameEmployeeWidget());
        print("rename ${employee.firstName}");
        break;
      case EmployeeTableCallbacks.GiveAdmin:
        Provider.of<DashboardViewModel>(context, listen: false)
            .setModalConfirmation(
                "Deseja mesmo conceder admin a ${employee.firstName}?",
                "${employee.firstName} terá acesso a todos seus relatórios financeiros",
                () {
          print("give admin ${employee.firstName}");
          Provider.of<DashboardViewModel>(context, listen: false).closeModal();
        }, () {
          Provider.of<DashboardViewModel>(context, listen: false).closeModal();
        });

        break;
      case EmployeeTableCallbacks.RemoveAdmin:
        Provider.of<DashboardViewModel>(context, listen: false)
            .setModalConfirmation(
                "Deseja mesmo retirar admin de ${employee.firstName}?", "", () {
          print("remove admin ${employee.firstName}");
          Provider.of<DashboardViewModel>(context, listen: false).closeModal();
        }, () {
          Provider.of<DashboardViewModel>(context, listen: false).closeModal();
        });
        break;
      case EmployeeTableCallbacks.RemoveEmployee:
        Provider.of<DashboardViewModel>(context, listen: false)
            .setModalConfirmation(
                "Deseja mesmo remover ${employee.firstName} de sua equipe?", "",
                () {
          print("remove ${employee.firstName}");
          Provider.of<DashboardViewModel>(context, listen: false).closeModal();
        }, () {
          Provider.of<DashboardViewModel>(context, listen: false).closeModal();
        });
        break;
    }
  }

  void goToAddEmployee(BuildContext context, EmployeeInfoViewModel viewModel) {
    addEmployeeController.text = "";
    Provider.of<DashboardViewModel>(context, listen: false)
        .setModalForm(AddEmployeeWidget(viewModel: viewModel));
  }

  void closeModal(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).closeModal();
  }

  TextEditingController addEmployeeController = TextEditingController();

  final renameEmployeeFormKey = GlobalKey<FormState>();
  TextEditingController renameFirstNameController = TextEditingController();
  TextEditingController renameLastNameController = TextEditingController();

  void addEmployee(BuildContext context) {}

  void renameEmployee(BuildContext context) {
    print("RENAMEE");
    Provider.of<DashboardViewModel>(context, listen: false).closeModal();
  }
}
