import 'package:flutter/material.dart';
import '../HistoriNotification.dart';
import 'package:intl/intl.dart';
import '../service/httpbd.dart';

class HistorialTipificacion extends StatefulWidget {
final int userDet;
HistorialTipificacion({required this.userDet});

  @override
  State<HistorialTipificacion> createState() => _HistorialTipificacionState();
}

class _HistorialTipificacionState extends State<HistorialTipificacion> {
  final HttpService httpService = HttpService();
  bool showMoreText = false;
  List<Map<String, dynamic>> buyTipificaciones = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // Iniciar el temporizador para cambiar automáticamente las imágenes
    _HistorialTipificacion();
    }
    void _HistorialTipificacion() async {
  setState(() {
    isLoading = true; // Iniciar el estado de carga
  });

  try {
    final moretipificaciones = await httpService.getHistorialTipificaciones();

    if (moretipificaciones != null) {
      List<Map<String, dynamic>> newBuyTipificaciones = [];

      for (int i = 0; i < moretipificaciones.length; i++) {
        newBuyTipificaciones.add({
          'id': moretipificaciones[i]['id'],
          'comment': moretipificaciones[i]['comment'],
          'created_at': moretipificaciones[i]['created_at'],
   
        });
      }

      setState(() {
        buyTipificaciones = newBuyTipificaciones;
        isLoading = false; // Finalizar el estado de carga
      });
    } else {
      // Manejar caso de productos nulos (puedes mostrar un mensaje de error o tomar otra acción)
    }
  } catch (e) {
    setState(() {
      isLoading = false; // Finalizar el estado de carga en caso de error
    });
    print('Error al obtener historial de tipificaciones: $e');
    // Manejar el error de acuerdo a tus necesidades (mostrar un mensaje de error, por ejemplo)
  }
}
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
                  Text("Mis tipificaciones",
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
                  itemCount: buyTipificaciones.length,
                  itemBuilder: (context, index) {
                    final tipificacion = buyTipificaciones[index];

                    String dateTimeString = tipificacion['created_at'];
                    List<String> dateTimeParts = dateTimeString.split('T');
                    String date = dateTimeParts[0]; // Obtener la fecha
                    String formattedDate =
                    DateFormat('dd MMM yyyy').format(DateTime.parse(date));
                    String time = dateTimeParts[1].split('.')[0];
                    String formattedTime = DateFormat('hh:mm a')
                    .format(DateTime.parse('2024-03-21 $time'))
                    .toLowerCase();
                    return ListTile(
                      title: Text('$formattedDate $formattedTime' ?? 'No disponible'),
                      subtitle: Text(tipificacion['comment'] ?? ''),
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