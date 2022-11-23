import 'package:flutter/material.dart';
import 'package:findjob_app/models/models.dart';

class JobFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Job job;

  JobFormProvider(this.job);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print("Form validado " + job.title);
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}
