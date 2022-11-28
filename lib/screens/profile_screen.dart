import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 150,
                        backgroundColor: const Color.fromRGBO(13, 13, 13, 0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(0), // Border radius
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(90), // Image radius
                              child: getImage(userAuth.photoUrl),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 10,
                        child: IconButton(
                          onPressed: () async {
                            final picker = ImagePicker();
                            final PickedFile? pickedFile =
                                await picker.getImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 100);
                            if (pickedFile == null) {
                              return;
                            }
                            //jobService
                            //.updateSelectedProductImage(pickedFile.path);
                            userDataService
                                .updateSelectedUserImage(pickedFile.path);
                            String? result =
                                await userDataService.uploadImage();

                            if (result != null) {
                              userDataService.authUserData.photoUrl = result;
                              await userDataService.updateCurrentUser();
                            }
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
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
                const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "objetvios",
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
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.phone),
                          ),
                          TextSpan(
                            text: "2222",
                            style: AppTheme.datos,
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.email_rounded),
                        ),
                        TextSpan(
                          text: "email",
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

  Widget getImage(String? picture) {
    if (picture == null) {
      return const Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );
    }

    if (picture.startsWith('http')) {
      return _profileImage(picture);
    }

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
