import 'package:crmproyect/HistoriNotification.dart';
import 'package:crmproyect/pages/PaginaHome.dart';
import 'package:flutter/material.dart';

class HistorialCursos extends StatefulWidget {
  const HistorialCursos({super.key});

  @override
  State<HistorialCursos> createState() => _HistorialCursosState();
}

class _HistorialCursosState extends State<HistorialCursos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: FutureBuilder(
      future: httpService.getTipificaciones(),
      builder: (context, snapshot){
        return Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: <Widget>[
              // Otros widgets...
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset('assets/Logo-simplificado-negro.png', height: 20, width: 130,),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoriNotification()),);
                }, 
                icon: Stack(
                  children: [
                    Icon(Icons.notifications, size: 40, color: Color.fromARGB(255, 149, 155, 160)),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              constraints: BoxConstraints(
                          minWidth:17,
                          minHeight: 17
                        ),
                        child: Text('0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10
                        ),
                        ),
                      )
                    )
                  ],
                )

                )
              ]
            ),
            SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.grey,)),
                      Text("Medio WhatsApp | 05/01/2024",
                      style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                           ),
                      ),
                    ],
                  ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mis cursos",
                    style:TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                            width: 130,
                            child: Center(child: Text("En seguimiento", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),)),
                            padding: EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                          )
                        ),
                ],
              ),
              Expanded( // Agrega un Expanded para permitir que el ListView ocupe el espacio restante
                child: ListView.builder(
                  //itemCount: buyTipificaciones.length,
                  itemBuilder: (context, index) {
                    //final tipificacion = buyTipificaciones[index];

                    /*String dateTimeString = tipificacion['created_at'];
                    List<String> dateTimeParts = dateTimeString.split('T');
                    String date = dateTimeParts[0]; // Obtener la fecha
                    String formattedDate =
                    DateFormat('dd MMM yyyy').format(DateTime.parse(date));
                    String time = dateTimeParts[1].split('.')[0];
                    String formattedTime = DateFormat('hh:mm a')
                    .format(DateTime.parse('2024-03-21 $time'))
                    .toLowerCase();*/
                    return ListTile(
                      //title: Text(tipificacion['created_at'] ?? 'No disponible'),
                      //subtitle: Text(tipificacion['comment'] ?? ''),
                      // Otros detalles del ListTile según tus necesidades
                    );
                  },
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              // Otros widgets...
            ],
          ),
        );
      }
    ),
  );
}
}