import 'package:findjob_app/screens/home_screen.dart';
import 'package:findjob_app/screens/registration_screen.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/widgets/arguments.dart';
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
                height: 100,
              ),
              CardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Iniciar sesión',
                      style: AppTheme.subEncabezado,
                      textAlign: TextAlign.center,
                    ),
                    
                    const LoginForm(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),            
                      child:MaterialButton(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                        height: 50.0,
                        onPressed: () {
                          Navigator.pushNamed(
                          context,'agregarUsuario',
                          arguments: WidgetArguments('modo', 'registro'),
                        );
                      },
                      color: Colors.white,
                        child: Text(
                          'Registrarse',
                          style: TextStyle(
                            color: Colors.black87
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

class LoginForm extends StatefulWidget{
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginForm createState()=>_LoginForm();
}

class _LoginForm extends State<LoginForm> {
  
  bool visible=false; 
  
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /**TextFormField:Correo electronico */
          Padding(
              padding: EdgeInsets.only(top:20.0),
              child:TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                
              style: TextStyle(
                 fontSize: 14.0,
                 color: Colors.black,
                ),

                decoration: InputDecoration(
                  labelText: "Correo",
                  hintText: "job@gmail.com",
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                  //suffixIcon: Icon(Icons.eyes),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,          
                  focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
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
          ),
          
          Padding(
              padding: EdgeInsets.only(top:20.0),
              child:TextFormField(
              obscureText: !visible,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              decoration: InputDecoration(
                labelText: "Contraseña",
                hintText: '*********',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  
                  icon:new Icon(visible?Icons.visibility:Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      visible=!visible;
                    });
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),      
                enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,          
                focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
              ),

              //Se valida el texto que se recibe
             validator: (value) {
              if (value != null && value.length >= 6) return null;
              return "La longitud debe de ser de 6 caracteres";
            },
            ),
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
