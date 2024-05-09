import 'package:crmproyect/presentation/screens/detail_user/DetalleInteresados.dart';
import 'package:flutter/material.dart';
import '../HistoriNotification.dart';
import '../service/httpbd.dart';

class ListaRecordatorios extends StatefulWidget {
  const ListaRecordatorios({super.key});

  @override
  State<ListaRecordatorios> createState() => _ListaRecordatoriosState();
}

class _ListaRecordatoriosState extends State<ListaRecordatorios> {
  final HttpService httpService = HttpService();
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 35.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.grey,)),
                      Text("Lista de Recordatorios",
                      style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                           ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder(
                          future: httpService.getRecordatorioByUser(),
                          builder: (context, snapshot){ //snap te trae las lista
                          return snapshot.hasData? ListView.separated( //separador de filas de la lista
                          itemCount: snapshot.data!.length,
                            itemBuilder:(context, index){
                              final interested_contacts = snapshot.data![index]; //api 
                              return ListTile(
                                title: Text(interested_contacts.intereContac?.fullName??'No presenta nombre'), //data user
                                subtitle: Text(interested_contacts.intereContac?.phone??'No presenta numero'),
                                trailing: Icon(Icons.arrow_forward_ios_rounded),
                                leading: CircleAvatar(
                        backgroundColor: (interested_contacts.user == 'Nuevo' ? Colors.green : Colors.orange),
                        foregroundColor: Colors.white,
                        child: Text(interested_contacts.user == 'Nuevo' ? 'N' : 'R'),
                      ),
                                onTap: ()=>
                                  Navigator.of(
                                    context).push 
                                    (MaterialPageRoute(
                                      builder: (BuildContext context)=>
                                      DetalleInteresados(userDet: interested_contacts.id??0,
                                      )
                                    //assignmentDate: interested_contacts.updatedAt!
                                    )),
                              );
                            },
                            separatorBuilder: (context, index)=> const Divider(),//parte del separador
                            ): Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,),
                            );
                          },
                        ),
                  ),
        ],
        ),
        ),
      ),
      );
  }
}