import 'package:crmproyect/service/httpbd.dart';
import 'package:flutter/material.dart';

class HistoriNotification extends StatefulWidget {
  const HistoriNotification({super.key});

  @override
  State<HistoriNotification> createState() => _HistoriNotificationState();
}

class _HistoriNotificationState extends State<HistoriNotification> {
  final HttpService httpService = HttpService();
  List<String> notifications = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/Logo-simplificado-negro.png', height: 20,width:130),
                ],
              ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.grey,)),
                      Text("Notificaciones",
                      style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                           ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
              Expanded(
                child: FutureBuilder(
                  future: httpService.getNotificationByUser(),
                    builder: (context,snapshot){
                  return snapshot.hasData? ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder:(context, index){
                    final  notifications= snapshot.data![index];
                    return ListTile(
                      onTap: (){
                      },
                      title: Text(
                        notifications.assignmentContact?.interested?.fullName ?? notifications.interested_contact?.fullName ?? 'Nombre no disponible',
                      ),
                      subtitle: Text(
                        notifications.assignmentContact?.interested?.phone ?? notifications.interested_contact?.phone ?? 'Teléfono no disponible',
                      ),
                      leading: CircleAvatar(
                        backgroundColor: (notifications.type == 'Nuevo' ? Colors.green : Colors.orange),
                        foregroundColor: Colors.white,
                        child: Text(notifications.type == 'Nuevo' ? 'N' : 'R'),
                      ),
                      trailing: Container(
                        width: 90,
                        height: 35,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text(notifications.type ?? 'Recordar', style: TextStyle(color: Colors.white),))
                        ),
                    );
                  },
                  separatorBuilder: (context, index)=> const Divider(),//parte del separador
                            ): Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,),
                 );
                }),
              ),
          ],
            ),
        ),
      ),
    );
  }
}