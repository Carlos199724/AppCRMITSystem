import 'package:crmproyect/models/models.dart';
import 'package:crmproyect/models/DetalleInterest.dart';
import 'package:crmproyect/presentation/screens/detail_user/DetalleInteresados.dart';
import 'package:crmproyect/service/httpbd.dart';
import 'package:flutter/material.dart';
import '../../HistoriNotification.dart';
import '../../models/item_dropdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName='/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HttpService httpService = HttpService();
  UserDetalle? userDetalle;
  final List<ItemDropdown> listSex=[
    ItemDropdown(label: 'En Seguimiento', value: 'enseg'),
    ItemDropdown(label: 'Pagará', value: 'pagr'),
    ItemDropdown(label: 'Pagado', value: 'pagd'),
    ItemDropdown(label: 'Caido-Calificado', value: 'cc'),
    ItemDropdown(label: 'Caido-No Calificado', value: 'cn'),
  ];
  ItemDropdown?_selectSex;
  final List<ItemDropdown> listStatus=[
    ItemDropdown(label: '2023', value: 'enseg'),
    ItemDropdown(label: '2022', value: 'pagr'),
    ItemDropdown(label: '2021', value: 'pagd'),
    ItemDropdown(label: '2020', value: 'cc'),
    ItemDropdown(label: '2019', value: 'cn'),
  ];
   ItemDropdown?_selectStatus;

  @override
  Widget build(BuildContext context) {

    return Scrollbar(
      thumbVisibility: true,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 35.0),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
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
                        Text("Lista de interesados",
                        style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                             ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  TextField(
                   onChanged: (text){
                   },
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                      hintText: "Buscar",
                      suffixIcon: const Icon(Icons.search),
                      // prefix: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [
                      SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: DropdownButton(
                                hint: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Estado'),
                                ),
                                isExpanded: true,
                                value: _selectSex,
                                underline: const SizedBox(),
                                items: listSex.map((item){
                                  return DropdownMenuItem(child: Text(item.label), 
                                  value: item);
                                }).toList(),
                                onChanged: (value){
                                  setState(() {
                                    _selectSex=value;
                                  });
                                }),
                            ),
                          ],
                        ),
                      ),
                      Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                child: DropdownButton(
                                  hint: Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Text('Fecha'),
                                  ),
                                  isExpanded: true,
                                  value: _selectStatus,
                                  underline: const SizedBox(),
                                  items: listStatus.map((item){
                                    return DropdownMenuItem(child: Text(item.label), 
                                    value: item);
                                  }).toList(),
                                  onChanged: (value){
                                    setState(() {
                                      _selectStatus=value;
                                    });
                                  }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                    ],
                  ),
                  SizedBox(height: 15,),
                    Expanded(
                      child: FutureBuilder(
                            future: httpService.getContactByUser(),
                            builder: (context, snapshot){ //snap te trae las lista
                            return snapshot.hasData? ListView.separated( //separador de filas de la lista
                            itemCount: snapshot.data!.length,
                              itemBuilder:(context, index){
                                final interested_contacts = snapshot.data![index]; //api 
                                return ListTile(
                                  title: Text(interested_contacts.fullName!), //data user
                                  subtitle: Text(interested_contacts.phone!),
                                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                                  leading: CircleAvatar(
                          backgroundColor:(interested_contacts.status?.statusName == 'Nuevo' ? Colors.green : Colors.orange),
                          foregroundColor: Colors.white,
                          child: Text(interested_contacts.status?.statusName=='Nuevo' ? 'N' : 'R'),
                        ),
                        onTap: ()=>
                                    Navigator.of(
                                      context).push 
                                      (MaterialPageRoute(
                                        builder: (BuildContext context)=>
                                        DetalleInteresados(userDet: interested_contacts.id ?? 0,
                                        ))),//assignmentDate: interested_contacts.assignmentDate!        
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
        ),
    );
  }
}