import 'package:findjob_app/widgets/item_oferta_tres.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/widget_arguments.dart';
import '../services/jobs_service.dart';
import '../widgets/item_oferta.dart';
import 'loading_screen.dart';

class MisSolicitudesScreen extends StatefulWidget{
  const MisSolicitudesScreen({Key? key}):super(key: key);

  @override
  _MisSolicitudesScreen createState()=>_MisSolicitudesScreen();
}

class _MisSolicitudesScreen extends State<MisSolicitudesScreen>{
  @override
  Widget build(BuildContext context){

    final jobsService = Provider.of<JobsService>(context);
    final jobsList = jobsService.myJobsSolicitados;
    if (jobsService.isLoading) return const LoadingScreen();

    
    return jobsList.length>0?Scaffold(
      body: ListView.builder(
        itemCount: jobsList.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            jobsService.selectedJob = jobsList[index].copy();
            Navigator.pushNamed(context, 'verOferta',arguments: WidgetArguments(edit: false,action:2));
          },
          child: JobCardTres(job: jobsList[index]),
        ),
      ),
    ):_emptyContainer();   
  }

   Widget _emptyContainer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.error_outline,
            color: Colors.black38,
            size: 130,
          ),
          Text(
            "Aún no envia alguna solicitud",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
   }
}