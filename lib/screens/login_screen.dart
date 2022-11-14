import 'package:findjob_app/screens/home_screen.dart';
import 'package:findjob_app/screens/registration_screen.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
                height: 200,
              ),
              CardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Iniciar sesion",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    
                    const _LoginForm(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),            
                      child:MaterialButton(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                        height: 50.0,
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationScreen()),
                        );
                      },
                      color: Color.fromRGBO(0, 77, 133, 1),
                        child: Text(
                          'Registrarse',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),   
                    ),
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

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Correo",
              hintText: "job@gmail.com",
              prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : "El formato no es valido";
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Contraseña",
              hintText: "***********",
              prefixIcon: Icon(Icons.lock_rounded),
            ),
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return "La longitud debe de ser de 6 caracteres";
            },
          ),
          Padding(
            padding: EdgeInsets.only(top:25.0,bottom: 15.0),            
            child:MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            height: 50.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              color: Color.fromRGBO(0, 77, 133, 1),
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                color: Colors.white
              )
            ),
          ),   
          ),
        ],
      ),
    );
  }
}
