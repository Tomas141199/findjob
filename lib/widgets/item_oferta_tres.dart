import 'package:findjob_app/models/job.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_theme.dart';

class JobCardTres extends StatelessWidget{
  final Job job;
  const JobCardTres({super.key, required this.job});

  @override
  Widget build(BuildContext context){

    String puesto="Nombre del trabajo";
    String fecha="12/12/2022";
    String salario="0.0";

    return Container(

      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTopBar(
            establishment: job.establishment,
            published: job.publishedAt,
            author: job.author,
          ),
        ],
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final String establishment;
  final String published;
  final String author;

  const _CardTopBar({
    Key? key,
    required this.establishment,
    required this.published,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        CircleAvatar(
          backgroundColor: AppTheme.getRandomColor(),
          child: Text(
            establishment[0],
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
              	    textAlign: TextAlign.right,
                    establishment,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "${DateFormat('yMd').format(DateTime.parse(published))} - $author",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
          
          IconButton(
        onPressed: (){
              print("Mostrar menu de opciones");
        }, 
            icon:Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
