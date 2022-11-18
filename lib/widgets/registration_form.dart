import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import 'arguments.dart';

class RegistrationForm extends StatefulWidget{
  const RegistrationForm({Key? key}):super(key: key);


  @override
  _RegistrationForm createState()=>_RegistrationForm();
}

class _RegistrationForm extends State<RegistrationForm>{
  bool visible=false;
  bool modoEdicion=false;


  TextEditingController dateInput = TextEditingController();
 
  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    
    final args = ModalRoute.of(context)!.settings.arguments as WidgetArguments;
    if(args.message=="edición")
      modoEdicion=true;
    else
      modoEdicion=false;

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

          //El siguiente campo solo se muestra en el modo de edición del formulario
          Visibility(
            visible: modoEdicion,
            child: Padding(
            padding: EdgeInsets.only(top:20.0),
            child: TextFormField(
              maxLines: 4, //or null 
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),

              //Decoración del textFormField
              decoration: InputDecoration(
                labelText: 'Descripción del empleo',
                contentPadding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                
                enabledBorder:AppTheme.lightTheme.inputDecorationTheme.enabledBorder,
                focusedBorder:AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
              ),
            ),
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
                modoEdicion?'Guardar cambios':'Registrarse',
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
