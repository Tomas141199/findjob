import 'package:findjob_app/models/job.dart';
import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/services/user_data_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/jobs_service.dart';
import '../theme/app_theme.dart';

class ItemChat extends StatelessWidget {
  final ChatUser chat;
  const ItemChat({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTopBar(
            idChat: chat.id!,
            usuario_destinatario: chat.usuario_destinatario,
            ultimo_mensaje: chat.ultimo_mensaje,
          ),
        ],
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final String idChat;
  final String usuario_destinatario;
  final String ultimo_mensaje;

  const _CardTopBar({
    Key? key,
    required this.idChat,
    required this.usuario_destinatario,
    required this.ultimo_mensaje,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobService = Provider.of<JobsService>(context);
    final userService = Provider.of<UserDataService>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.getRandomColor(),
            child: Text(
              usuario_destinatario[0],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${this.usuario_destinatario}",
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${this.ultimo_mensaje}",
                        style: TextStyle(color: Colors.grey.shade500,fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                context: context,
                builder: (context) {
                  return Wrap(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Ver perfil del usuario'),
                          onTap: () async {
                            print("idUsuario ${idChat}");
                            
                            await userService.setUserSelected(idChat).then((value){
                              print("Datos del usuario encontrado");
                              Navigator.of(context).pop();
                              Navigator.pushNamed(context, 'userDetails');
                            });
                            print("tap");
                          },
                        ),
                      ),  
                    ],
                  );
                },
              );
              //bpp,
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return TextButton(
      style: AppTheme.flatButtonStyle,
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  void alerta(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: const Text('No se han encontrado postulantes'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Aceptar'),
                ),
              ],
            ));
  }
}
