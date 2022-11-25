import 'package:flutter/material.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/widgets/widgets.dart';
import 'package:findjob_app/models/models.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../validator/validator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              CardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Iniciar sesión',
                      style: AppTheme.subEncabezado,
                      textAlign: TextAlign.center,
                    ),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const LoginForm(),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, "registro",
                          arguments: WidgetArguments(edit: false)),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const StadiumBorder()),
                      ),
                      child: const Text("Registrarse"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {  
    final jobService = Provider.of<JobsService>(context);    
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /**TextFormField:Correo electronico */
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                labelText: "Correo",
                hintText: "job@gmail.com",
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
              validator: (value) {
                return value!.isValidEmail;
              },
              onChanged: (value) => loginForm.email = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              obscureText: !visible,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              decoration: InputDecoration(
                labelText: "Contraseña",
                hintText: '*********',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                ),
              ),

              //Se valida el texto que se recibe
              validator: (value) {
                return value!.isValidPassword;
              },
              onChanged: (value) => loginForm.password = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              height: 50.0,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {

                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final String? errorMessage = await authService.login(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        await jobService.loadJobs();
                        await jobService.loadMyJobs();
                        Navigator.pushReplacementNamed(context, 'home');

                      } else {
                        NotificationsService.showSnackBar(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
              color: AppTheme.deepBlue,
              child: Text(
                loginForm.isLoading ? 'Espere' : 'Iniciar sesión',
                style: TextStyle(
                    color: loginForm.isLoading ? Colors.black : Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
