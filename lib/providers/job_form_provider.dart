import 'package:flutter/material.dart';

class JobFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = "";
  String photoUrl = "";
  String job = "";
  String salary = "";
  String description = "";
  String address = "";
  String city = "";
  String town = "";

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}
