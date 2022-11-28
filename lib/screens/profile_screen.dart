import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/screens/screens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _ProfileScreenBody();
  }
}

class _ProfileScreenBody extends StatelessWidget {
  const _ProfileScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDataService = Provider.of<UserDataService>(context);

    if (userDataService.isLoading) return const LoadingScreen();

    final userAuth = userDataService.authUserData;
    print(userAuth.birthday);
    print(userAuth.contactEmail);
    print(userAuth.description);
    print(userAuth.displayName);
    print(userAuth.docUrl);
    print(userAuth.ownerId);
    print(userAuth.photoUrl); 
    print(userAuth.tel);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.primary,
        body: Container(
          height: double.infinity,
          decoration: AppTheme.backgroundRounded,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 100.0, left: 100.0),
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromRGBO(13, 13, 13, 0.8), width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundColor: const Color.fromRGBO(13, 13, 13, 0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(0), // Border radius
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(90), // Image radius
                          child: _profileImage(userAuth.photoUrl??"https://www.fcmlindia.com/images/fifty-days-campaign/no-image.jpg"),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  userAuth.displayName,
                  style: AppTheme.subEncabezado,
                ),
                //Datos de usuario
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Aptitudes y objetivos',
                    style: AppTheme.subEncabezadoDos,
                  ),
                ),
                 Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      userAuth.description!=null?userAuth.description.toString():"No se ha ingresado los datos de este apartado.",
                      style: AppTheme.datos,
                    )),
                //Información de contacto del usuario
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Información de contacto',
                    style: AppTheme.subEncabezadoDos,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: RichText(
                      text:  TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.phone),
                          ),
                          TextSpan(
                            text:" "+userAuth.tel.toString(),
                            style: AppTheme.datos,
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RichText(
                    text:  TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.email_rounded),
                        ),
                        TextSpan(
                          text: " "+userAuth.contactEmail.toString(),
                          style: AppTheme.datos,
                        ),
                      ],
                    ),
                  ),
                ),
                //Verificación de los datos
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Verificación de datos',
                    style: AppTheme.subEncabezadoDos,
                  ),
                ),
                //Carga de documentos
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Documentos',
                    style: AppTheme.subEncabezadoDos,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: _edit(context),
        //_edit(),
      ),
    );
  }

  CachedNetworkImage _profileImage(String photoUrl) {
    return CachedNetworkImage(
      imageUrl: photoUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(photoUrl),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  FloatingActionButton _edit(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
        Navigator.pushNamed(
          context,
          'editarUsuario',
          arguments: WidgetArguments(edit: true),
        );
      },
      elevation: 4,
      backgroundColor: AppTheme.deepBlue,
      child: const Icon(Icons.edit),
    );
  }
}
