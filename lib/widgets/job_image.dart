import 'package:flutter/material.dart';

class JobImage extends StatelessWidget {
  const JobImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: 450,
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: const ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: FadeInImage(
            image: NetworkImage(
                "https://d500.epimg.net/cincodias/imagenes/2019/11/04/lifestyle/1572892359_005767_1572892909_noticia_normal.jpg"),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]);
}
