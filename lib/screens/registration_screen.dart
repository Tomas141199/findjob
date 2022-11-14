import 'package:findjob_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class RegistrationScreen extends StatefulWidget{
  const RegistrationScreen({Key? key}):super(key: key);

  @override
  _RegistrationScreen createState()=>_RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen>{

  bool visible=false;
  TextEditingController dateInput = TextEditingController();
 
  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(4, 135, 217, 1),
            elevation: 0,
            title: const Text(
                "FindJob",
                textAlign: TextAlign.center,
                style:TextStyle(
                  color:Color.fromRGBO(255, 252, 252, 1),
                  fontSize:25.0,
                  fontWeight: FontWeight.bold,
                  fontFamily:'Arial',
                )
              ),
          centerTitle: true,
        ), 
        body: Container(
          
          height: double.infinity,

          child:Expanded(
          child:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top:30.0,right: 25.0,left: 25.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 252, 252, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
               
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Formulario de registro',
                  style: AppTheme.subEncabezado,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                   child:_FormularioInicioSesion(context), 
                ),  
                
              ],
            ),    
          ),
        ),
      ),
        ),
      ),
    );
  }

  Form _FormularioInicioSesion(BuildContext context){
    return Form(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          Padding(
            padding: EdgeInsets.only(top:10.0),            
            child:TextFormField(
              
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              
              
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.usb_rounded,color: Colors.transparent,),
                labelText: "Nombre",
                hintText: 'Juan Perez Hernandez',
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                
                enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,
                focusedBorder:AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
              ),

              //Se valida el texto que se recibe
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Es necesario ingresar un texto';
                }
                return null;
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
                prefixIcon: Icon(Icons.lock,color: Colors.transparent,),
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
              padding: EdgeInsets.only(top:20.0),
              child:TextFormField(
              
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]{0,10}$')),
                  
                ],
               style: TextStyle(
                 fontSize: 14.0,
                 color: Colors.black,
                ),

                decoration: InputDecoration(
                  labelText: "Telefono",
                  hintText: '*******890',
                  prefixIcon: Icon(Icons.phone,color: Colors.transparent,),
                  //suffixIcon: Icon(Icons.eyes),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,          
                  focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
                ),

              //Se valida el texto que se recibe
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Es necesario ingresar un texto';
                }
                return null;
              },
            ),
          ),


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
                  prefixIcon: Icon(Icons.alternate_email_rounded, color: Colors.transparent,),
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

          /**TextFormField:Fecha de nacimiento */
          Padding(
              padding: EdgeInsets.only(top:20.0),
              child:TextFormField(
                controller: dateInput,
                readOnly: true,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),

                decoration: InputDecoration(
                  labelText: "Fecha Nacimiento",
                  hintText: 'aa/mm/dd',
                  prefixIcon: Icon(Icons.cake), //icon of text field
                 
                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  //Estilo del borde cuando el input esta habilitado
                  enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,          
                  focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
                ),

              //Se valida el texto que se recibe
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Es necesario ingresar un texto';
                }
                return null;
              },


              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                            formattedDate; //set output date to TextField value.
                        });
                  } else {}
              },

            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:30.0,bottom:30.0),
            child:MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            height: 50.0,
              onPressed: () {
                
              },
              color: Color.fromRGBO(0, 77, 133, 1),
              child: Text(
                'Registrarse',
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