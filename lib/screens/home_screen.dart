
import 'package:findjob_app/screens/jobs_screen.dart';
import 'package:findjob_app/screens/messages_screen.dart';
import 'package:findjob_app/screens/profile_screen.dart';
import 'package:findjob_app/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}):super(key: key);

  @override
  _HomeScreen createState()=>_HomeScreen();
}

class _HomeScreen extends State<HomeScreen>{

  int currentIndex=0;
  List _lisPages=[];
  late Widget currentPage;

  @override
  void initState(){
    super.initState();

    _lisPages
      ..add(SearchScreen())
      ..add(JobsScreen())
      ..add(MessagesScreen())
      ..add(ProfileScreen());

    currentPage=SearchScreen();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(4, 135, 217, 1),
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
          body: Center(
          child: Container(
            
            padding: EdgeInsets.only(top:15, bottom:15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 252, 252, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),

            child: currentPage,
          ),
          ),
        bottomNavigationBar:Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 252, 252, 1),
          ),
        
          child:Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(143, 148, 150, 1), width: 2),
            color: Color.fromRGBO(255, 252, 252, 1),

           borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
          ),
          child:BottomNavigationBar(
          
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 24,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          selectedItemColor: Color.fromRGBO(0, 77, 133, 1),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          selectedLabelStyle: Theme.of(context).textTheme.bodyText1?.merge(const TextStyle(color: Colors.white, fontSize: 12)),
          unselectedLabelStyle: Theme.of(context).textTheme.button?.merge(const TextStyle(color: Colors.white, fontSize: 11)),
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon:new Icon(Icons.work),
              label: 'Empleos',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.chat),
              label: 'Mensajes',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          onTap: (selectedIndex) => _ChangePage(selectedIndex),
        ),
        ), 
        ),
      ),
    );
  }

  void _ChangePage(int selectedIndex){
    setState(() {
      currentIndex=selectedIndex;
      currentPage=_lisPages[selectedIndex];
    });
  }
}