//import 'package:crmproyect/secon.dart';//
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../HistoriNotification.dart';
import '../../../models/item_dropdown.dart';
import '../../../service/httpbd.dart';
import '../../../pages/HistorialTipificacion.dart';
import '../../../pages/MasDetalleInteresados.dart';
import '../../../pages/OpcionesInterest.dart';

class DetalleInteresados extends StatefulWidget {
  final int userDet;
  //final String assignmentDate;//
  DetalleInteresados({required this.userDet});//required this.assignmentDate

  @override
  State<DetalleInteresados> createState() => _DetalleInteresadosState();
}

class _DetalleInteresadosState extends State<DetalleInteresados> {
  String _cursoContacto = '';
  bool _isSent = false;
  bool _isLoading = false;
  //File? _imageFile;
  String _errorMessage = '';
Future<void> _enviarDatos() async {
  // Verificar que los campos no estén vacíos
  if (_cursoContacto.isEmpty) {
    _showSnackBar('Todos los campos son obligatorios', Colors.red);
    return;
  }

  setState(() {
    _isLoading = true;
    _errorMessage = ''; // Limpiar cualquier mensaje de error anterior
  });

  // Obtenemos los datos del comentario y la fecha
  String cursoContacto = _cursoContacto;
  //String fechaDate = _fechaRecord;//

  // Enviamos los datos al servidor
  dynamic response =
      await HttpService().RegisterCursos(cursoContacto, widget.userDet);
  if (response != null && response is Map<String, dynamic>) {
    if (response.containsKey('error')) {
      setState(() {
        _isLoading = false;
        _errorMessage = response['error'];
      });
      _showSnackBar(_errorMessage, Colors.red);
    } else {
      // Mostrar un mensaje de éxito predeterminado
      _showSnackBar('¡Datos enviados con éxito!', Colors.green);
      setState(() {
        _isSent = true; // Establecer _isSent solo si el envío fue exitoso
        _isLoading = false;
      });
    }
  } else {
    setState(() {
      _isLoading = false;
      _errorMessage = 'Ocurrió un error al procesar la respuesta.';
    });
    _showSnackBar(_errorMessage, Colors.red);
  }
}

void _showSnackBar(String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ),
  );
}
void _onDropdownChanged(ItemDropdown value) {
  setState(() {
    _cursoContacto = value.label; // Actualiza _cursoContacto con el valor seleccionado del DropdownButton
  });
}
  final HttpService httpService = HttpService();
  
  final List<ItemDropdown>listSex =[
    ItemDropdown(label: 'Digitación', value: 'dg'),
    ItemDropdown(label: 'Análisis', value: 'an'),
    ItemDropdown(label: 'Base de datos', value: 'bd'),
  ];
  ItemDropdown? _selectSex;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: FutureBuilder(
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
                                  FittedBox(
                                    child: Container(
                                      width: 150,
                                      child: Center(child: Text(interesDetalle.status?.statusName?? 'Estado vacio',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),)),
                                      padding: EdgeInsets.all(11),
                                      decoration: BoxDecoration(
                                        color: Colors.cyan[100],
                                        borderRadius: BorderRadius.circular(20),
                                    )
                                                            ),
                                  ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: BoxConstraints.expand(height: 100),
                            decoration: BoxDecoration(color: Colors.grey[100],
                            boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 0.75)
                                )
                              ],
                            borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Curso \nRegistrado:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[600],
                                  ),
                                  ),
                                  Container(
                                    width: 180,
                                    child: Center(child: 
                                    Row(
                                      children: [
                                        Text(interesDetalle.originCourse!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey[800]),),
                                      ],
                                    )),
                                    padding: EdgeInsets.all(11),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue[50],
                                      borderRadius: BorderRadius.circular(20),
                                  )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: BoxConstraints.expand(height: 100),
                            decoration: BoxDecoration(color: Colors.grey[100],
                            boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 0.75)
                                )
                              ],
                            borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                                children: [
                                  Column(
                                    children: [ 
                                      Row(
                                        children: [
                                          Text("Contacto:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[600],  
                                  ),
                                ),
                                
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(interesDetalle.phone!, style: TextStyle(fontSize: 18,color: Colors.grey[600],  
                                  ),
                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _launchURL('https://wa.me/${interesDetalle.phone}');
                                    },
                                    child: Icon( //<-- SEE HERE
                                    Icons.phone,color: Colors.white,
                                    size: 40,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      backgroundColor: Colors.green, //<-- SEE HERE
                                      padding: EdgeInsets.all(15),
                                      ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Correo electrónico:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[600],
                                            ),
                                            ),
                                            Text(
                                              interesDetalle.email!,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[600],
                                                ),
                                                ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ocupación:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[600]
                                            ),
                                            ),
                                            Text(
                                              interesDetalle.occupation??'No presenta ocupación',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[600],
                                                ),
                                                ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text('Cursos a inscribirse', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey[600]
                                          ),
                                          ),
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 5.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              child: DropdownButton(
                                                hint: Text('Ingrese curso ...'),
                                                isExpanded: true,
                                                value: _selectSex,
                                                underline: SizedBox(),
                                                items: listSex.map((item){
                                                  return DropdownMenuItem(
                                                    value: item,
                                                    child: Text(item.label),
                                                    );
                                                  }).toList(),
                                                  onChanged: (dynamic value){
                                                    setState(() {
                                                      _selectSex=value;
                                                      });
                                                      _onDropdownChanged(value);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            SizedBox(width: 5),
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.save, color: Colors.white),
                                                  onPressed: _isLoading ? null : (){
                                                    // Lógica para guardar aquí
                                                    if (_isSent) {
                                                      // Muestra el mensaje de error
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('Ya enviaste tu reporte'),
                                                          backgroundColor: Colors.red
                                                        ),
                                                      );
                                                      } else {
                                                        // Si no se ha enviado un reporte, llama al método _enviarDatos
                                                      _enviarDatos();
                                                      }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                      SizedBox(height: 15,),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistorialTipificacion(userDet: interesDetalle.id ??0)));
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                constraints: BoxConstraints(maxHeight: 60, minHeight: 50),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 10.0,
              offset: Offset(0.0, 0.75)
            )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Historial de tipificaciones",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistorialTipificacion(userDet: interesDetalle.id ?? 0,)));
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                constraints: BoxConstraints(maxHeight: 60, minHeight: 50),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 10.0,
              offset: Offset(0.0, 0.75)
            )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Historial de cursos",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
                  ),
                ),
              ),
            ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                      Container(
                                        height: 100,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: TextButton.icon(
                                            onPressed: () => 
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MasDetalleInteresados(userDet: interesDetalle.id ?? 0,)//assignmentDate: assignmentDate
                                              
                                              ,)),
                                            icon: Column(
                                              children: [
                                                Icon(Icons.add,
                                                color: Colors.blue,
                                                size: 35,),
                                                Text('Detalles',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      label: Text(
                                                        '', //'Label',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                        ),
                                      ),
                              Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: TextButton.icon(
                                            onPressed: () => {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OpcionesUser(userDet: interesDetalle.id?? 0),))
                                            },
                                            icon: Column(
                                              children: [
                                                Icon(Icons.edit,
                                                color: Colors.blue,
                                                size: 35,),
                                                Text('Opciones',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      label: Text(
                                                        '', //'Label',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                        ),
                          ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          ElevatedButton.icon(
                            onPressed: (){
                             //boton de llamar corregir
                             _makePhoneCall(interesDetalle.phone!);
                            }, 
                            icon: Icon(Icons.phone), 
                            label: Text("Llamar"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),), backgroundColor: Colors.blue,
                              padding: EdgeInsets.all(1.0),
                              fixedSize: Size(411, 45),
                              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              elevation: 10,
                              shadowColor: Colors.lightBlue[100],
                              side: BorderSide(color: Colors.blue, width: 1),
                              ),
                              ),
                                  ],
                                ),
                              ),
                            ],
                          )      
                  ],
                    ),
                 );
                }
                ),
          ),
        ),
           ),
    );
        }
        void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }
  void _makePhoneCall(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se pudo realizar la llamada a $phoneNumber';
  }
}
}
