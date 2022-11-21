import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/widgets/item_oferta.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      body:CustomScrollView(
        
        slivers:<Widget> [
        
          SliverAppBar(
            
            backgroundColor: Colors.white,
            floating: true,
            pinned: true,
            elevation: 2,
            snap: false,
            automaticallyImplyLeading:false,
              title: Container(
                width: double.infinity,
                height: 40,
                child: const Center(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Ingresa una palabra clave...',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.arrow_right_alt_sharp),
                    ),
                  ),
                ),
              ),

              bottom: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading:false,
                title: Container(
                  width: double.infinity,
                  height: 40,
                  child: const Center(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ingrese una ciudad...',
                        prefixIcon: Icon(Icons.location_city),
                        suffixIcon: Icon(Icons.arrow_right_alt_sharp)),
                      ),
                    ),
                  ),
            ),
          ),

      
          _listaItemOfertas(),
        ],
      ),  
    
    );
  }

  Widget _listaItemOfertas(){
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(3, (int index){
          return WidgetOferta();
        }
      ),
      ),
    );
  }
}
