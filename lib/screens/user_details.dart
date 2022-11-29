import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final userService = Provider.of<UserDataService>(context);
    final user = userService.selectedUser;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(user),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _PosterAndTitle(user),
              _Overview(user.description!, ""),
              _OverviewVerificacion(user, "Validación de datos"),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextButton(
                  onPressed: () async {
                    final url = user.docUrl;
                    if (url != null) {
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        throw "Could not launch $url";
                      }
                    } else {
                      NotificationsService.showSnackBar(
                          "Este usuario no cuenta con documentación");
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  child: const Text("Ver Documentos",
                      style: AppTheme.subEncabezadoDos),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final UserData user;

  const _CustomAppBar(this.user);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primary,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/giphy.gif'),
          image: NetworkImage(user.photoUrl ??
              "https://www.fcmlindia.com/images/fifty-days-campaign/no-image.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final UserData user;

  const _PosterAndTitle(this.user);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 10, top: 10),
            child: Hero(
              tag: user.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.png'),
                  image: NetworkImage(user.photoUrl ??
                      "https://www.fcmlindia.com/images/fifty-days-campaign/no-image.jpg"),
                  height: 150,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Text(user.displayName,
                      style: TextStyle(
                          fontSize: 20,
                          color: AppTheme.deepBlue,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Text(user.tel.toString(),
                      style: textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Text(user.contactEmail,
                      style: textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String description;
  final String title;
  const _Overview(this.description, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            title.length > 0
                ? Text(
                    title,
                    style: AppTheme.subEncabezadoDos,
                  )
                : Text(
                    '',
                  ),
            Text(
              "\n" + description + "\n",
              style: AppTheme.datos,
            ),
          ],
        ));
  }
}

class _OverviewVerificacion extends StatelessWidget {
  final UserData user;
  final String title;
  const _OverviewVerificacion(this.user, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
          
            Text(
              title,
              style: AppTheme.subEncabezadoDos,
            ),
            Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.check),
                        ),
                        TextSpan(
                          text: " Telefono verificado",
                          style: AppTheme.datos,
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.close),
                        ),
                        TextSpan(
                          text: " Correo electronico no verificado",
                          style: AppTheme.datos,
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ));
  }
}

