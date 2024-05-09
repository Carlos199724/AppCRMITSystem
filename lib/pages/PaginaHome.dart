import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../HistoriNotification.dart';
import '../service/httpbd.dart';
import 'ListaRecordatorios.dart';

class PaginaHome extends StatefulWidget {

  @override
  State<PaginaHome> createState() => _PaginaHomeState();
  
}
final HttpService httpService = HttpService();
  List<String> notifications = [];
  int notificationCount = notifications.length;
class _PaginaHomeState extends State<PaginaHome> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: Scaffold(
        body: FutureBuilder(
          future: httpService.getDashboarddUser(), 
          builder: (context, snapshot){
                // Obtén el primer objeto UserDetalle de la lista
           final interesDetalle = snapshot.data!;
          return Container(
            child: Padding( 
              padding: const EdgeInsets.all(35.0),
              child: Column(
                children: <Widget>[
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
                            child: Text(
                              notificationCount.toString(),
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
                      SizedBox(height: 9,),
                      Row(
                        children: [
                          Text("Resumen de Datos",
                          style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                               ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        child: Container(
                          //height: MediaQuery.of(context).size.height * 0.75,//
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Flexible(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text('Nuevos',
                                          style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context).size.width * 0.03, // Ajusta el tamaño del texto según el ancho de la pantalla
                                          ),
                                        ),
                                          Spacer(),
                                          Text((interesDetalle.statusFrequency?.nuevo ?? 0).toString(),
                                          style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context).size.width * 0.03, // Ajusta el tamaño del texto según el ancho de la pantalla
                                          ),
                                        ),
                                        ],
                                      ),
                                      Center(
                                        child: Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.2, // Ajusta el ancho del contenedor según el ancho de la pantalla
                                            height: MediaQuery.of(context).size.width * 0.2, // Ajusta la altura del contenedor según el ancho de la pantalla
                                            child: CircularPercentIndicator(
                                              radius: MediaQuery.of(context).size.width * 0.10, // Ajusta el tamaño del círculo según el ancho de la pantalla
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: MediaQuery.of(context).size.width * 0.10, // Ajusta el grosor de la línea según el ancho de la pantalla
                                              percent: 0.1,
                                              center: Text(
                                                '${((interesDetalle.statusFrequency?.nuevo ?? 0) + (interesDetalle.substatusFrequency?.confirmar ?? 0)) * 10}%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.035, // Ajusta el tamaño del texto según el ancho de la pantalla
                                                  ),
                                                ),
                                              circularStrokeCap: CircularStrokeCap.butt,
                                              backgroundColor: Colors.grey,
                                              progressColor: ((interesDetalle.statusFrequency?.nuevo ?? 0) + (interesDetalle.substatusFrequency?.confirmar?? 0)) > 0 ? Colors.pink.shade200 : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),  
                                  SizedBox(height: 0,),
                                  Row(
                                    children: [
                                      Text(
                                        'Por confirmar',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context).size.width * 0.03, // Ajusta el tamaño del texto según el ancho de la pantalla
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          (interesDetalle.substatusFrequency?.confirmar ?? 0).toString(),
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w600,
                                            fontSize: MediaQuery.of(context).size.width * 0.03, // Ajusta el tamaño del texto según el ancho de la pantalla
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                                          ),
                                ),
                                          ),
                            ),
                            Flexible(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text('Reasignado',
                                          style: const TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          ),
                                          Spacer(),
                                          Text((interesDetalle.statusFrequency?.reasignado?? 0).toString(),
                                      style: TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      ),
                                        ],
                                      ),
                                      Center(
                                        child: Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.2, // Ajusta el ancho del contenedor según el ancho de la pantalla
                                            height: MediaQuery.of(context).size.width * 0.2, // Ajusta la altura del contenedor según el ancho de la pantalla
                                            child: CircularPercentIndicator(
                                              radius: MediaQuery.of(context).size.width * 0.10, // Ajusta el tamaño del círculo según el ancho de la pantalla
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: MediaQuery.of(context).size.width * 0.10, // Ajusta el grosor de la línea según el ancho de la pantalla
                                              percent: 0.1,
                                              center: Text(
                                                '${((interesDetalle.statusFrequency?.reasignado?? 0)+(interesDetalle.statusFrequency?.caidocalificado?? 0))*10}%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.035, // Ajusta el tamaño del texto según el ancho de la pantalla
                                                  ),
                                                ),
                                              circularStrokeCap: CircularStrokeCap.butt,
                                              backgroundColor: Colors.grey,
                                              progressColor: ((interesDetalle.statusFrequency?.reasignado ?? 0) + (interesDetalle.statusFrequency?.caidocalificado ?? 0)) > 0 ? Colors.cyan : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text('Caido calificado',
                                          style: const TextStyle(
                                            color:Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          ),
                                          Spacer(),
                                          Text((interesDetalle.statusFrequency?. caidocalificado?? 0).toString(),
                                      style: TextStyle(
                                        color:Colors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      ),
                                        ],
                                      ),
                                  ],
                                                          ),
                                ),
                                          ),
                            ),
                            ]
                            ),
                            ),
                                            ],)),
                            Flexible(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text('En seguimiento',
                                          style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: MediaQuery.of(context).size.width * 0.03,
                                          ),
                                          ),
                                          Spacer(),
                                          Text((interesDetalle.statusFrequency?. enseguimiento?? 0).toString(),
                                      style: const TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      ),
                                        ],
                                      ),
                                      Center(
                                        child: Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.2, // Ajusta el ancho del contenedor según el ancho de la pantalla
                                            height: MediaQuery.of(context).size.width * 0.2, // Ajusta la altura del contenedor según el ancho de la pantalla
                                            child: CircularPercentIndicator(
                                              radius: MediaQuery.of(context).size.width * 0.10, // Ajusta el tamaño del círculo según el ancho de la pantalla
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: MediaQuery.of(context).size.width * 0.10, // Ajusta el grosor de la línea según el ancho de la pantalla
                                              percent: 0.1,
                                              center: Text(
                                                '${((interesDetalle.statusFrequency?.enseguimiento?? 0)+(interesDetalle.substatusFrequency?.confirmar?? 0))*10}%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.035, // Ajusta el tamaño del texto según el ancho de la pantalla
                                                  ),
                                                ),
                                              circularStrokeCap: CircularStrokeCap.butt,
                                              backgroundColor: Colors.grey,
                                              progressColor: ((interesDetalle.statusFrequency?.enseguimiento?? 0) + (interesDetalle.substatusFrequency?.confirmar?? 0)) > 0 ? Colors.orange : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text('Confirmará',
                                          style: TextStyle(
                                            color:Colors.blue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: MediaQuery.of(context).size.width * 0.03,
                                          ),
                                          ),
                                          Spacer(),
                                          Text((interesDetalle.substatusFrequency?. confirmar?? 0).toString(),
                                      style: const TextStyle(
                                        color:Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      ),
                                        ],
                                      ),
                                  ],
                                                          ),
                                ),
                                          ),
                            ),
                            Flexible(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text('Reasignado',
                                          style: const TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          ),
                                          Spacer(),
                                          Text((interesDetalle.statusFrequency?. enseguimiento?? 0).toString(),
                                      style: TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      ),
                                        ],
                                      ),
                                      Center(
                                        child: Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.2, // Ajusta el ancho del contenedor según el ancho de la pantalla
                                            height: MediaQuery.of(context).size.width * 0.2, // Ajusta la altura del contenedor según el ancho de la pantalla
                                            child: CircularPercentIndicator(
                                              radius: MediaQuery.of(context).size.width * 0.10, // Ajusta el tamaño del círculo según el ancho de la pantalla
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: MediaQuery.of(context).size.width * 0.10, // Ajusta el grosor de la línea según el ancho de la pantalla
                                              percent: 0.1,
                                              center: Text(
                                                '${((interesDetalle.statusFrequency?.enseguimiento?? 0)+(interesDetalle.substatusFrequency?.porLlamar?? 0))*10}%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.035, // Ajusta el tamaño del texto según el ancho de la pantalla
                                                  ),
                                                ),
                                              circularStrokeCap: CircularStrokeCap.butt,
                                              backgroundColor: Colors.grey,
                                              progressColor: ((interesDetalle.statusFrequency?.enseguimiento?? 0) + (interesDetalle.substatusFrequency?.porLlamar?? 0)) > 0 ? Colors.blue : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text('Caido calificado',
                                          style: const TextStyle(
                                            color:Colors.purple,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          ),
                                          Spacer(),
                                          Text((interesDetalle.substatusFrequency?. porLlamar?? 0).toString(),
                                      style: TextStyle(
                                        color:Colors.purple,
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      ),
                                        ],
                                      ),
                                  ],
                                                          ),
                                ),
                                          ),
                            ),
                            ]
                            ),
                            ),

                                            ],)),
                                            Flexible(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text('Pagará',
                                          style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: MediaQuery.of(context).size.width * 0.03,
                                          ),
                                          ),
                                          Spacer(),
                                          Text((interesDetalle.statusFrequency?. pagara?? 0).toString(),
                                      style: TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      ),
                                        ],
                                      ),
                                      Center(
                                        child: Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.2, // Ajusta el ancho del contenedor según el ancho de la pantalla
                                            height: MediaQuery.of(context).size.width * 0.2, // Ajusta la altura del contenedor según el ancho de la pantalla
                                            child: CircularPercentIndicator(
                                              radius: MediaQuery.of(context).size.width * 0.10, // Ajusta el tamaño del círculo según el ancho de la pantalla
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: MediaQuery.of(context).size.width * 0.10, // Ajusta el grosor de la línea según el ancho de la pantalla
                                              percent: 0.1,
                                              center: Text(
                                                '${(interesDetalle.statusFrequency?.pagara?? 0)*10}%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.035, // Ajusta el tamaño del texto según el ancho de la pantalla
                                                  ),
                                                ),
                                              circularStrokeCap: CircularStrokeCap.butt,
                                              backgroundColor: Colors.grey,
                                              progressColor: ((interesDetalle.statusFrequency?.pagara?? 0)+0) > 0 ? Colors.yellow : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text('',
                                      style: TextStyle(
                                        color:Colors.green,
                                        fontWeight: FontWeight.w600,  
                                      ),
                                      ),
                                  ],
                                                          ),
                                ),
                                          ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text('Pagado',
                                          style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: MediaQuery.of(context).size.width * 0.03,
                                          ),
                                          ),
                                          Spacer(),
                                          Text((interesDetalle.statusFrequency?. pagado?? 0).toString(),
                                      style: TextStyle(
                                        color:Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                      ),
                                      ),
                                        ],
                                      ),
                                      Center(
                                        child: Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.2, // Ajusta el ancho del contenedor según el ancho de la pantalla
                                            height: MediaQuery.of(context).size.width * 0.2, // Ajusta la altura del contenedor según el ancho de la pantalla
                                            child: CircularPercentIndicator(
                                              radius: MediaQuery.of(context).size.width * 0.10, // Ajusta el tamaño del círculo según el ancho de la pantalla
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: MediaQuery.of(context).size.width * 0.10, // Ajusta el grosor de la línea según el ancho de la pantalla
                                              percent: 0.1,
                                              center: Text(
                                                '${(interesDetalle.statusFrequency?.pagado?? 0)*10}%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.035, // Ajusta el tamaño del texto según el ancho de la pantalla
                                                  ),
                                                ),
                                              circularStrokeCap: CircularStrokeCap.butt,
                                              backgroundColor: Colors.grey,
                                              progressColor: ((interesDetalle.statusFrequency?.pagara?? 0)+0) > 0 ? Colors.green : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Text('',
                                      style: TextStyle(
                                        color:Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      ),
                                  ],
                                                          ),
                                ),
                            ),
                          ),
                                            ],)),
                                            SizedBox(height: 10,),
                                            Row(
                        children: [
                          Text('Total de resultados: ${(interesDetalle.totalStatus?? 0)}', style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],),),
                        ],
                                            ),
                                            SizedBox(height: 5,),
                                            ElevatedButton.icon(
                        onPressed: () => 
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ListaRecordatorios(),)),
                        icon: Icon(Icons.add_alarm), 
                        label: Text("Recordatorios"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue, padding: EdgeInsets.all(1.0), backgroundColor: Colors.lightBlue[100],
                          fixedSize: Size(411, 45),
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          elevation: 10,
                          shadowColor: Colors.lightBlue[100],
                          side: BorderSide(color: Colors.blue, width: 1),
                        ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text("¡Sigue asi! Lograras tu meta del mes.", style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black, 
                                            fontWeight: 
                                            FontWeight.bold),),
                              ]
                            ),
                            
                            ),
                                          
                        ),
                      ),
                      ],
            ),
            ),
          );
        }),
        ),
    );
  }
  }
  
  