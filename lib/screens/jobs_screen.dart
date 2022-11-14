import 'package:findjob_app/screens/missolicitudes_screen.dart';
import 'package:findjob_app/screens/myjobs_screen.dart';
import 'package:flutter/material.dart';

class JobsScreen extends StatefulWidget{
  const JobsScreen({Key? key}):super(key: key);

  @override
  _JobsScreen createState()=>_JobsScreen();
}

class _JobsScreen extends State<JobsScreen>{
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              
              child:TabBar(

                indicatorColor: Color.fromRGBO(0, 77, 133, 1),
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Mis ofertas',
                  ),
                  Tab(text: 'Solicitudes'),
                ],
              ) ,
            ),
            
          ),
          body: TabBarView(
            
            children: <Widget> [
              MyJobsScreen(),
              MisSolicitudesScreen(),
            ],
          ),
      ),
      ),
    );
  }
}