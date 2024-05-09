import 'package:crmproyect/pages/PaginaHome.dart';
import 'package:crmproyect/presentation/screens.dart';
import 'package:crmproyect/widget/CambioPassword.dart';
import 'package:crmproyect/widget/LoginPage.dart';
import 'package:flutter/material.dart';

class Second extends StatefulWidget {


  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  int _paginaActual= 0;
  List<Widget>_paginas=[
    PaginaHome(),
    HomeScreen(),
  ];         //declarando para el menu
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_paginaActual], //interaccion de paginas menu
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _paginaActual,
          onTap: (index){
                setState(() {
                  _paginaActual=index;
                  
                });
              },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
            BottomNavigationBarItem(icon: Icon(Icons.menu_open), label: "Lista"),
            BottomNavigationBarItem(
              icon: PopupMenuButton(
                offset: Offset(200,-110),
                itemBuilder: (BuildContext context){
                  return[
                    PopupMenuItem(
                    child:ListTile(
                      leading: Icon(Icons.change_circle_outlined),
                      title: Text('Cambiar Contraseña'),
                    ), 
                    onTap: () async {
                                final navigator = Navigator.of(context);
                                await Future.delayed(Duration.zero);
                                navigator.push(
                                  MaterialPageRoute(builder: (_) => CambioPassword()),
                                  );
                                  },
                  ),
                  PopupMenuItem(
                    child:ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title:Text('Cerrar Sessión'), 
                    ),
                    onTap: () async {
                                final navigator = Navigator.of(context);
                                await Future.delayed(Duration.zero);
                                navigator.push(
                                  MaterialPageRoute(builder: (_) => MyHomePage()),
                                  );
                                  },
                  ),
                  ];
                },
                child: Icon(Icons.person),
                ),
                label: 'Usuario',
                )
          ],
          ),
    );
  }
}
//creando pestañas de navegación del menu

  
  