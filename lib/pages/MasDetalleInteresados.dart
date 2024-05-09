
import 'package:flutter/material.dart';

import '../HistoriNotification.dart';
import '../service/httpbd.dart';

class MasDetalleInteresados extends StatefulWidget {
  final int userDet;
 //final String assignmentDate;//
  MasDetalleInteresados({required this.userDet});//required this.assignmentDate

  @override
  State<MasDetalleInteresados> createState() => _MasDetalleInteresadosState();
}

class _MasDetalleInteresadosState extends State<MasDetalleInteresados> {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: httpService.getDetalleUser(widget.userDet),
        
        builder: (context, snapshot){
              // Obtén el primer objeto UserDetalle de la lista
            final interesDetalle = snapshot.data!;
            //final assignmentDate = widget.assignmentDate;//   
        return Padding(
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
                      
                      Text('Medio',//${interesDetalle.mediumContact.toString()} | ${assignmentDate.substring(0, 10)} | ${assignmentDate.substring(12, 16)}
                      style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                           ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(interesDetalle.fullName!,
                          style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                               ),
                          ),
                          Container(
                            width: 130,
                            child: Center(child: Text(interesDetalle.status?.statusName?? 'Estado vacio', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),)),
                            padding: EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              color: Colors.cyan[100],
                              borderRadius: BorderRadius.circular(20),
                          )
                        ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Mas detalles",
                              style:TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                   ),
                              ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Ocupación", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[700],
                                ),
                                ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(interesDetalle.occupation??'No presenta ocupación', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey,
                                ),
                                ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Empresa", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[700],
                                ),
                                ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(interesDetalle.companyName??'No pertenece a ninguna empresa', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey,
                                ),
                                ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Empresa usa SAP", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[700],
                                ),
                                ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(interesDetalle.useSap == true ? "Si" : "No", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey,
                                ),
                                ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Número de documento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[700],
                                ),
                                ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(interesDetalle.nroDocument??'No presenta numero N° de documento', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey,
                                ),
                                ),
                      ],
                    ),
                  ),
          ],
            ),
        );
        }
      ),
    );
  }
}